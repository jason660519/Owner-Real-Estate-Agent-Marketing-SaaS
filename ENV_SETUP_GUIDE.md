# 環境變數設置指南

## 🚀 快速設置

### 方法一：使用提供的腳本（推薦）
```bash
# 在專案根目錄執行
source setup_env_vars.sh
```

### 方法二：永久設置到 Shell 配置檔案
```bash
# 將環境變數添加到您的 shell 配置檔案
echo 'source ~/Desktop/Owner Real Estate Agent SaaS/setup_env_vars.sh' >> ~/.zshrc
# 然後重新載入配置
source ~/.zshrc
```

### 方法三：手動設置個別變數
```bash
export GITHUB_TOKEN="your_token_here"
export OPENAI_API_KEY="your_openai_key"
# ... 其他變數
```

## 🔧 驗證設置

檢查環境變數是否設置成功：
```bash
echo $GITHUB_TOKEN
echo $OPENAI_API_KEY
echo $DATABASE_URL
```

## 📋 需要手動設置的變數

以下變數需要您手動獲取和設置：

### 🏢 Slack 配置
- **SLACK_TEAM_ID**: 
  1. 打開 Slack 桌面應用
  2. 點選工作空間名稱 → 設定與管理 → 工作空間設定
  3. 在 URL 中找到 Team ID（T開頭的字串）

### 📝 Notion API Key
- **NOTION_API_KEY**:
  1. 訪問 [Notion Developers](https://developers.notion.com/)
  2. 創建新的內部整合
  3. 獲取 Internal Integration Token

### 🗄️ 資料庫設置
- **DATABASE_URL**: 
  ```bash
  # 本地 PostgreSQL
  export DATABASE_URL="postgresql://postgres:your_password@localhost:5432/realestate_saas"
  
  # 遠端資料庫
  export DATABASE_URL="postgresql://user:pass@host:5432/dbname"
  ```

### ☁️ AWS 設置（物業圖片存儲）
- **AWS_ACCESS_KEY_ID** 和 **AWS_SECRET_ACCESS_KEY**:
  1. 登入 AWS 控制台
  2. IAM → 用戶 → 創建訪問金鑰
  3. 設置 S3 存儲桶權限

## 🛡️ 安全性最佳實踐

### 1. 檔案權限
```bash
# 確保腳本檔案安全
chmod 600 setup_env_vars.sh
```

### 2. Git 忽略
確保 `.gitignore` 包含：
```
.env
setup_env_vars.sh
*.key
*.pem
```

### 3. 定期輪換
- 定期更新 API keys
- 使用有限權限的服務帳戶
- 監控 API 使用情況

## 🔍 故障排除

### Claude Code 無法連接服務
```bash
# 檢查 MCP 服務器狀態
npx @anthropic/mcp-github --version
npx @anthropic/mcp-postgres --version
```

### 資料庫連接失敗
```bash
# 測試 PostgreSQL 連接
psql $DATABASE_URL -c "SELECT version();"
```

### API Key 無效
```bash
# 測試 GitHub API
curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user

# 測試 OpenAI API  
curl -H "Authorization: Bearer $OPENAI_API_KEY" https://api.openai.com/v1/models
```

## 🎯 房地產 SaaS 專用設置

### 地理位置服務
```bash
# Google Maps API (用於物業地址驗證)
export GOOGLE_MAPS_API_KEY="$GOOGLE_API_KEY"
```

### 圖片存儲
```bash
# S3 存儲桶 (物業圖片)
export S3_BUCKET_NAME="realestate-property-images"
export AWS_REGION="us-west-2"
```

### 通知系統  
```bash
# Slack 通知 (租賃狀態更新)
export SLACK_CHANNEL_NOTIFICATIONS="#property-updates"
```

---

**🔐 重要提醒**: 請確保這些 API keys 的安全性，不要分享或提交到公開的程式碼庫！