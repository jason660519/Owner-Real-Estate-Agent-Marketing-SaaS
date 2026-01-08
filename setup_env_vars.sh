#!/bin/bash

# 房地產 SaaS 環境變數設置腳本
# 使用方法: source setup_env_vars.sh

echo "🚀 設置房地產 SaaS 專案環境變數..."

# AI 模型 API Keys (請填入您的實際 API Keys)
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"
export OPENAI_API_KEY="your-openai-api-key-here"
export DEEPSEEK_API_KEY="your-deepseek-api-key-here"
export GEMINI_API_KEY="your-gemini-api-key-here"
export GOOGLE_API_KEY="your-google-api-key-here"
export GROK_API_KEY="your-grok-api-key-here"
export TOGETHER_AI_API_KEY="your-together-ai-api-key-here"
export OPENROUTER_API_KEY="your-openrouter-api-key-here"

# 開發工具 API Keys (請填入您的實際 API Keys)
export GITHUB_TOKEN="your-github-token-here"
export GITHUB_PERSONAL_ACCESS_TOKEN="your-github-pat-here"
export CURSOR_API_KEY="your-cursor-api-key-here"
export CONTEXT7_API_KEY="your-context7-api-key-here"

# 雲服務和整合 (請填入您的實際 API Keys)
export SLACK_BOT_TOKEN="your-slack-bot-token-here"
export SLACK_TEAM_ID="T1234567890"  # 請從您的 Slack 工作空間獲取正確的 Team ID
export NOTION_API_KEY="secret_xxxxxx"  # 請從 Notion 開發者設定獲取
export HUGGINGFACE_API_TOKEN="your-huggingface-token-here"
export FIRECRAWL_API_KEY="your-firecrawl-api-key-here"

# 其他工具 (請填入您的實際 API Keys)
export NGROK_AUTHTOKEN="your-ngrok-auth-token-here"
export SHODAN_API_KEY="your-shodan-api-key-here"
export KIMI_K2="your-kimi-api-key-here"
export LLAMA_CLOUD_API_KEY="your-llama-cloud-api-key-here"

# Google Drive OAuth (請修改為您的實際路徑)
export GDRIVE_OAUTH_PATH="/Users/jason66/Desktop/Owner Real Estate Agent SaaS/client_secret.json"

# 資料庫和基礎設施 (請修改為您的實際設定)
export DATABASE_URL="postgresql://postgres:password@localhost:5432/realestate_saas"
export REDIS_URL="redis://localhost:6379"
export DOCKER_HOST="unix:///var/run/docker.sock"

# 房地產 SaaS 專用設定
export SECRET_KEY="your-super-secret-key-$(date +%s)"
export ALGORITHM="HS256"
export AWS_ACCESS_KEY_ID="your-aws-access-key"
export AWS_SECRET_ACCESS_KEY="your-aws-secret-key"
export S3_BUCKET_NAME="realestate-files"

# 需要申請的 API Keys (請替換為實際值)
export SLACK_TEAM_ID="T1234567890"  # 從 Slack 工作空間獲取
export NOTION_API_KEY="secret_xxxxxx"  # 從 Notion 開發者設定獲取
export DATABASE_URL="postgresql://postgres:password@localhost:5432/realestate_saas"  # 設定資料庫連接

# 推薦申請的房地產專用 API Keys
export STRIPE_SECRET_KEY="sk_test_xxxxxx"  # 支付處理
export STRIPE_PUBLISHABLE_KEY="pk_test_xxxxxx"
export SENDGRID_API_KEY="SG.xxxxxx"  # 郵件服務
export TWILIO_ACCOUNT_SID="ACxxxxxx"  # SMS 服務
export TWILIO_AUTH_TOKEN="xxxxxx"
export TWILIO_PHONE_NUMBER="+1234567890"
export MAPBOX_ACCESS_TOKEN="pk.xxxxxx"  # 地圖服務

echo "✅ 環境變數設置完成！"
echo ""
echo "🚨 立即需要申請的 API Keys:"
echo "   1. NOTION_API_KEY (https://developers.notion.com/)"
echo "   2. DATABASE_URL (推薦 Supabase: https://supabase.com/)"
echo "   3. SLACK_TEAM_ID (從您的 Slack 工作空間獲取)"
echo ""
echo "⭐ 房地產功能推薦申請:"
echo "   4. STRIPE API Keys (https://stripe.com/)"
echo "   5. SENDGRID_API_KEY (https://sendgrid.com/)"
echo "   6. TWILIO Keys (https://twilio.com/)"
echo "   7. MAPBOX_ACCESS_TOKEN (https://mapbox.com/)"
echo ""
echo "🔧 使用方法："
echo "   source setup_env_vars.sh"
echo "   或者將這些變數添加到 ~/.zshrc 或 ~/.bash_profile"

