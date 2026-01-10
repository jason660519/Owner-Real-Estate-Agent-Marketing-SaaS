#!/bin/bash

# Real Estate SaaS Skill Evaluation Hook
# Analyzes user prompts to suggest relevant real estate development skills

USER_PROMPT="$CLAUDE_USER_PROMPT"
PROJECT_DIR="$CLAUDE_PROJECT_DIR"

# Define skill keywords for real estate SaaS
declare -A SKILL_KEYWORDS=(
    ["property-management"]="property|listing|rent|lease|tenant|landlord|maintenance|inspection"
    ["user-authentication"]="auth|login|signup|user|account|profile|permission|role"
    ["agent-dashboard"]="agent|dashboard|analytics|stats|commission|client|lead"
    ["search-filtering"]="search|filter|sort|query|criteria|location|price|bedroom|bathroom"
    ["payment-processing"]="payment|stripe|paypal|transaction|billing|invoice|deposit"
    ["database-design"]="database|schema|model|migration|relationship|query|index"
    ["api-development"]="api|endpoint|rest|graphql|fastapi|backend|server|route"
    ["frontend-components"]="react|component|ui|interface|form|modal|table|responsive"
    ["docker-deployment"]="docker|container|compose|deployment|kubernetes|devops"
    ["testing-patterns"]="test|spec|unit|integration|e2e|mock|fixture|assertion"
)

# Check if any skill keywords match the prompt
SUGGESTED_SKILLS=""
for skill in "${!SKILL_KEYWORDS[@]}"; do
    keywords="${SKILL_KEYWORDS[$skill]}"
    if echo "$USER_PROMPT" | grep -iE "$keywords" >/dev/null 2>&1; then
        SUGGESTED_SKILLS="$SUGGESTED_SKILLS$skill "
    fi
done

# Check file paths for context
if echo "$USER_PROMPT" | grep -E "(frontend/|backend/|docker)" >/dev/null 2>&1; then
    if echo "$USER_PROMPT" | grep "frontend/" >/dev/null 2>&1; then
        SUGGESTED_SKILLS="$SUGGESTED_SKILLS""frontend-components "
    fi
    if echo "$USER_PROMPT" | grep "backend/" >/dev/null 2>&1; then
        SUGGESTED_SKILLS="$SUGGESTED_SKILLS""api-development database-design "
    fi
    if echo "$USER_PROMPT" | grep -iE "(docker|compose)" >/dev/null 2>&1; then
        SUGGESTED_SKILLS="$SUGGESTED_SKILLS""docker-deployment "
    fi
fi

# Output suggestions if any found
if [ -n "$SUGGESTED_SKILLS" ]; then
    echo "Suggested real estate SaaS skills: $SUGGESTED_SKILLS"
    echo "Available skills in .claude/skills/ directory"
fi