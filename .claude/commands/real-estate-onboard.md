# Real Estate SaaS Onboarding

您好！歡迎來到房地產 SaaS 專案。

## 專案背景

這是一個多租戶房地產管理 SaaS 平台，支持：

- **業主 (Owner)**: 發布和管理物業，查看收益分析
- **代理商 (Agent)**: 管理客戶，協助租賃和銷售，追蹤佣金
- **租客 (Renter)**: 搜尋物業，申請租賃，管理租約
- **買家 (Buyer)**: 瀏覽物業，聯繫代理商，提交購買意向

## 技術架構

### 前端 (Frontend)
- **框架**: React 18 + TypeScript
- **狀態管理**: TanStack Query + Zustand
- **UI 框架**: Tailwind CSS + Headless UI
- **表單管理**: React Hook Form + Zod 驗證
- **部署**: Docker 容器化

### 後端 (Backend)
- **框架**: Python FastAPI
- **數據庫**: PostgreSQL + PostGIS (地理查詢)
- **ORM**: SQLAlchemy + Alembic (遷移)
- **緩存**: Redis
- **認證**: JWT + OAuth2
- **任務隊列**: Celery
- **部署**: Docker 容器化

### 基礎設施
- **容器編排**: Docker Compose
- **反向代理**: Nginx
- **文件存儲**: AWS S3 / MinIO
- **監控**: Prometheus + Grafana
- **CI/CD**: GitHub Actions

## 開發工作流程

### 分支策略
- `main`: 生產分支，受保護
- `develop`: 開發分支
- `feature/*`: 功能開發分支
- `bugfix/*`: 錯誤修復分支

### 功能分支命名約定
- `feature/property-listing`: 物業列表功能
- `feature/user-authentication`: 用戶認證
- `feature/agent-dashboard`: 代理商儀表板
- `feature/payment-integration`: 支付整合
- `feature/search-filtering`: 搜尋過濾功能

### 代碼品質保證
- **前端**: Prettier + ESLint + TypeScript 嚴格模式
- **後端**: Black + Pylint + mypy 類型檢查
- **測試**: Jest (前端) + pytest (後端)
- **代碼覆蓋率**: 目標 80% 以上

## 專案結構說明

```
Owner Real Estate Agent SaaS/
├── frontend/                 # React 前端應用
│   ├── src/
│   │   ├── components/      # 可重用組件
│   │   ├── pages/          # 頁面組件
│   │   ├── hooks/          # 自定義 React hooks
│   │   ├── services/       # API 調用服務
│   │   ├── types/          # TypeScript 類型定義
│   │   └── utils/          # 工具函數
│   ├── public/             # 靜態資源
│   ├── package.json        # 前端依賴
│   └── Dockerfile          # 前端容器配置
│
├── backend/                 # FastAPI 後端應用
│   ├── app/
│   │   ├── models/         # SQLAlchemy 數據模型
│   │   ├── schemas/        # Pydantic 數據模式
│   │   ├── routers/        # API 路由
│   │   ├── services/       # 業務邏輯服務
│   │   ├── core/           # 核心配置和工具
│   │   └── tests/          # 後端測試
│   ├── migrations/         # 數據庫遷移
│   ├── requirements.txt    # Python 依賴
│   └── Dockerfile          # 後端容器配置
│
├── docs/                   # 專案文檔
├── .claude/               # Claude Code 配置
├── docker-compose.yml     # 本地開發環境
└── README.md             # 專案說明
```

## 核心業務模型

### 用戶模型
```python
class User(BaseModel):
    id: UUID
    email: str
    role: UserRole  # OWNER, AGENT, RENTER, BUYER
    profile: UserProfile
    created_at: datetime
```

### 物業模型
```python
class Property(BaseModel):
    id: UUID
    owner_id: UUID
    title: str
    description: str
    property_type: PropertyType  # APARTMENT, HOUSE, CONDO, etc.
    price: Decimal
    location: Location  # 地理位置信息
    amenities: List[Amenity]
    images: List[PropertyImage]
    status: PropertyStatus  # AVAILABLE, RENTED, PENDING
```

### 租約模型
```python
class Lease(BaseModel):
    id: UUID
    property_id: UUID
    tenant_id: UUID
    agent_id: Optional[UUID]
    start_date: date
    end_date: date
    monthly_rent: Decimal
    deposit: Decimal
    status: LeaseStatus  # ACTIVE, EXPIRED, TERMINATED
```

## 開發環境設定

### 前置需求
- Docker & Docker Compose
- Node.js 18+ (用於前端開發)
- Python 3.11+ (用於後端開發)
- PostgreSQL 15+ (用於本地數據庫)

### 快速啟動
```bash
# 克隆專案
git clone <repository-url>
cd "Owner Real Estate Agent SaaS"

# 啟動完整開發環境
docker-compose up -d

# 或者分別啟動服務
cd frontend && npm install && npm start
cd backend && pip install -r requirements.txt && uvicorn main:app --reload
```

### 環境變數配置
創建 `.env` 檔案：
```
# 數據庫
DATABASE_URL=postgresql://user:password@localhost:5432/realestate_saas

# Redis
REDIS_URL=redis://localhost:6379

# JWT
SECRET_KEY=your-secret-key
ALGORITHM=HS256

# 文件存儲
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
S3_BUCKET_NAME=realestate-files

# 第三方服務
STRIPE_SECRET_KEY=sk_test_...
SENDGRID_API_KEY=SG....
```

## 重要開發指南

### API 設計原則
- 使用 RESTful 設計模式
- 統一的錯誤回應格式
- API 版本控制 (v1, v2)
- 請求/回應驗證
- 適當的 HTTP 狀態碼

### 前端開發規範
- 組件化設計，單一職責原則
- TypeScript 嚴格模式，禁用 `any`
- 響應式設計，移動優先
- 無障礙設計 (a11y) 考慮
- 性能優化 (懶載入、虛擬化)

### 後端開發規範
- 依賴注入模式
- 異步編程 (async/await)
- 數據驗證和清理
- 適當的日誌記錄
- 單元測試覆蓋

### 數據庫設計原則
- 正規化設計，避免數據冗餘
- 適當的索引策略
- 外鍵約束和數據完整性
- 軟刪除機制
- 審計字段 (created_at, updated_at)

## 測試策略

### 前端測試
- **單元測試**: React Testing Library + Jest
- **集成測試**: 組件交互測試
- **E2E 測試**: Playwright 自動化測試

### 後端測試
- **單元測試**: pytest + pytest-asyncio
- **集成測試**: 數據庫操作測試
- **API 測試**: FastAPI TestClient

## 部署和監控

### 生產環境部署
- Kubernetes 集群部署
- Helm charts 配置管理
- 藍綠部署策略
- 自動擴縮容

### 監控和觀察性
- 應用性能監控 (APM)
- 日誌聚合和分析
- 錯誤追蹤和告警
- 業務指標儀表板

## 學習資源

### 文檔連結
- [FastAPI 官方文檔](https://fastapi.tiangolo.com/)
- [React 官方文檔](https://react.dev/)
- [PostgreSQL 文檔](https://www.postgresql.org/docs/)
- [Docker 最佳實踐](https://docs.docker.com/develop/dev-best-practices/)

### 房地產領域知識
- 物業管理最佳實踐
- 租賃法律要求
- 房地產市場分析
- 用戶體驗設計

## 獲得幫助

如果您在開發過程中遇到問題：

1. 檢查專案文檔和 README
2. 查看相關的單元測試示例
3. 使用 Claude Code 的房地產技能和代理商
4. 查看 Git 提交歷史了解類似功能的實現
5. 聯繫團隊成員或在專案頻道提問

歡迎開始您的房地產 SaaS 開發之旅！ 🏠✨