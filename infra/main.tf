# ==========================
# AGENT 1 - SUPERVISOR
# ==========================
resource "aws_bedrockagent_knowledge_base" "kb_supervisor" {
  name        = "kb-supervisor"
  description = "Base de conhecimento do agente supervisor"
  type        = "VECTOR"
}

resource "aws_bedrockagent_guardrail" "guardrail_supervisor" {
  name        = "guardrail-supervisor"
  description = "Guardrail base supervisor"
}

resource "aws_bedrockagent_orchestration_strategy" "strategy_supervisor" {
  name        = "orchestration-supervisor"
  description = "Orquestração base supervisor"
}

resource "aws_bedrockagent_agent" "agent_supervisor" {
  name                      = "agent-supervisor"
  instruction               = "Agente supervisor customizável"
  foundation_model          = var.foundation_model
  knowledge_base_ids        = [aws_bedrockagent_knowledge_base.kb_supervisor.id]
  guardrail_ids             = [aws_bedrockagent_guardrail.guardrail_supervisor.id]
  orchestration_strategy_id = aws_bedrockagent_orchestration_strategy.strategy_supervisor.id
}

# ==========================
# AGENT 2 - COLABORADOR
# ==========================
resource "aws_bedrockagent_knowledge_base" "kb_colaborador" {
  name        = "kb-colaborador"
  description = "Base de conhecimento do agente colaborador"
  type        = "VECTOR"
}

resource "aws_bedrockagent_guardrail" "guardrail_colaborador" {
  name        = "guardrail-colaborador"
  description = "Guardrail base colaborador"
}

resource "aws_bedrockagent_orchestration_strategy" "strategy_colaborador" {
  name        = "orchestration-colaborador"
  description = "Orquestração base colaborador"
}

resource "aws_bedrockagent_agent" "agent_colaborador" {
  name                      = "agent-colaborador"
  instruction               = "Agente colaborador customizável"
  foundation_model          = var.foundation_model
  knowledge_base_ids        = [aws_bedrockagent_knowledge_base.kb_colaborador.id]
  guardrail_ids             = [aws_bedrockagent_guardrail.guardrail_colaborador.id]
  orchestration_strategy_id = aws_bedrockagent_orchestration_strategy.strategy_colaborador.id
}

# ==========================
# MULTI-AGENT COLLABORATION
# ==========================
resource "aws_bedrockagent_collaboration" "multi_agent" {
  name        = "colaboration-supervisor-colaborador"
  agent_ids   = [aws_bedrockagent_agent.agent_supervisor.id, aws_bedrockagent_agent.agent_colaborador.id]
  description = "Integração entre supervisor e colaborador"
}

# ==========================
# ACTION GROUP SHARED
# ==========================
resource "aws_bedrockagent_action_group" "shared_action_group" {
  name                 = "action-shared"
  agent_ids            = [aws_bedrockagent_agent.agent_supervisor.id, aws_bedrockagent_agent.agent_colaborador.id]
  lambda_arn           = var.lambda_arn
  action_schema_s3_uri = var.schema_yaml_s3_uri
}