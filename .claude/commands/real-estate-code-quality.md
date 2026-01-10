# Real Estate SaaS Code Quality Check

您被要求對房地產 SaaS 專案執行代碼品質檢查。

## 目標
$ARGUMENTS

## 檢查項目

### 1. 房地產業務邏輯檢查
- **物業數據完整性**: 必填字段驗證（地址、價格、類型、狀態）
- **用戶角色權限**: 業主、代理商、租客、買家的權限邊界
- **搜尋過濾邏輯**: 位置、價格範圍、房型篩選的正確性
- **租賃工作流**: 租約創建、續約、終止的業務邏輯
- **支付流程**: 押金、租金、佣金計算的準確性

### 2. 前端代碼品質
```bash
# TypeScript 類型檢查
cd frontend && npx tsc --noEmit

# ESLint 代碼規範檢查
npx eslint src/ --ext .ts,.tsx

# Prettier 代碼格式檢查
npx prettier --check src/

# React Hook 使用規範
eslint src/ --rule "react-hooks/rules-of-hooks: error"
```

### 3. 後端代碼品質
```bash
# Python 代碼格式檢查
cd backend && python -m black --check .

# Pylint 代碼品質分析
pylint app/

# mypy 類型檢查
mypy app/

# 安全漏洞掃描
bandit -r app/
```

### 4. 數據庫設計檢查
- **關係完整性**: 外鍵約束和級聯操作
- **索引優化**: 查詢性能相關索引
- **數據一致性**: 事務邊界和隔離級別
- **遷移安全性**: 數據遷移的向後兼容性

### 5. API 設計檢查
- **RESTful 設計**: HTTP 動詞和狀態碼使用
- **請求驗證**: Pydantic 模型驗證
- **錯誤處理**: 統一錯誤回應格式
- **文檔完整性**: OpenAPI/Swagger 文檔

### 6. 安全性檢查
```bash
# 前端安全掃描
npm audit

# 後端依賴安全檢查
cd backend && pip-audit

# 環境變數洩露檢查
grep -r "password\|secret\|key" --exclude-dir=node_modules .
```

### 7. 性能檢查
- **數據庫查詢**: N+1 查詢問題檢測
- **前端性能**: 組件重渲染優化
- **圖片優化**: 大圖檔壓縮和懶載入
- **API 響應時間**: 複雜查詢的性能分析

### 8. 測試覆蓋率
```bash
# 前端測試覆蓋率
cd frontend && npm test -- --coverage

# 後端測試覆蓋率
cd backend && pytest --cov=app --cov-report=html
```

## 房地產特定檢查

### 物業搜尋邏輯
```typescript
// 檢查搜尋參數驗證
interface PropertySearchFilters {
  location?: string;
  minPrice?: number;
  maxPrice?: number;
  propertyType?: PropertyType;
  bedrooms?: number;
  bathrooms?: number;
  amenities?: string[];
}
```

### 地理查詢優化
```python
# 檢查 PostGIS 查詢效率
def check_location_queries():
    # 確保地理索引存在
    # 檢查距離查詢的性能
    pass
```

### 用戶權限檢查
```python
# 檢查 RBAC 實現
def check_permissions():
    # 業主只能管理自己的物業
    # 代理商只能查看授權的物業
    # 租客只能查看自己的租約
    pass
```

## 報告格式

### 嚴重問題 (Critical)
- 安全漏洞
- 數據完整性問題
- 破壞性變更
- 業務邏輯錯誤

### 警告問題 (Warning)
- 性能問題
- 代碼規範違反
- 缺少測試覆蓋
- 不一致的 API 設計

### 建議改進 (Suggestion)
- 代碼重構機會
- 文檔改進
- 用戶體驗優化
- 技術債務清理

## 執行步驟

1. **運行自動化檢查工具**
```bash
# 完整的代碼品質檢查
./scripts/quality-check.sh
```

2. **手動代碼審查**
- 查看最近的 Git 提交
- 重點審查業務邏輯變更
- 檢查 API 端點的安全性

3. **測試執行**
```bash
# 運行所有測試
docker-compose -f docker-compose.test.yml up --abort-on-container-exit
```

4. **生成品質報告**
- 代碼覆蓋率報告
- 靜態分析結果
- 性能基準測試
- 安全掃描報告

5. **問題分類和優先級**
- 按嚴重程度排序
- 估算修復工作量
- 制定修復計劃

開始進行房地產 SaaS 專案的全面代碼品質檢查。