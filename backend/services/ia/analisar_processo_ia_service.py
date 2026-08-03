import json
import os

from google import genai
from pydantic import BaseModel, Field

from repositories import ProcessoMinerarioRepository


class AnaliseProcesso(BaseModel):
    resumo: str = Field(description="Resumo breve e simples do processo minerário.")
    situacao_atual: str = Field(
        description="Explicação da fase e do último evento registrado."
    )
    pontos_atencao: list[str] = Field(
        description="Pontos que merecem acompanhamento pelo usuário."
    )
    observacao: str = Field(
        description="Aviso sobre os limites informativos da análise."
    )


class AnalisarProcessoIAService:

    def __init__(self):
        api_key = os.getenv("GEMINI_API_KEY")

        if not api_key:
            raise RuntimeError("A chave GEMINI_API_KEY não foi configurada.")

        self.client = genai.Client(api_key=api_key)

    def executar(self, id_processo):
        processo = ProcessoMinerarioRepository.buscar_detalhes(id_processo)

        if processo is None:
            raise ValueError("Processo não encontrado.")

        prompt = f"""
Você é um assistente de apoio à leitura de processos minerários.

Analise exclusivamente os dados fornecidos abaixo.

Regras:
- Use linguagem simples, objetiva e acessível.
- Não invente fatos, documentos, decisões, prazos ou obrigações.
- Não faça recomendações jurídicas.
- Não afirme que o processo está regular ou irregular.
- Explique termos técnicos apenas com base no contexto disponível.
- Os pontos de atenção devem indicar apenas o que pode ser acompanhado
  pelo usuário.
- Mantenha o resumo e a situação atual com no máximo 3 frases cada.
- Retorne no máximo 3 pontos de atenção.
- Evite repetir informações entre resumo e situação atual.

Dados do processo:

Número: {processo["processo"]}
Ano: {processo["ano"]}
Substância: {processo["subs"]}
Fase: {processo["fase"]}
Área: {processo["area_ha"]} hectares
Nome: {processo["nome"]}
Uso: {processo["uso"]}
Último evento: {processo["ult_evento"]}
Data do último evento: {processo["dt_ult_evento"]}
"""

        interaction = self.client.interactions.create(
            model="gemini-3.5-flash-lite",
            input=prompt,
            response_format={
                "type": "text",
                "mime_type": "application/json",
                "schema": AnaliseProcesso.model_json_schema(),
            },
        )

        return json.loads(interaction.output_text)
