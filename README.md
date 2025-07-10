# GST
A comprehensive GST reporting view in Oracle SQL.
ERP-GST-View/
├── VIEW_GST.sql              # SQL view for GST transaction and tax reporting
└── README.md                 # Project documentation

# ERP GST View – Oracle SQL for Tax Reporting

## 🧾 Overview

`VIEW_GST` is a comprehensive Oracle SQL View that consolidates all Goods and Services Tax (GST) related data from multiple ERP modules such as sales, purchase, and journal vouchers. It covers both item-level GST transactions and accounting-level GST entries across different tax natures and posting codes.

---

## 📄 Files Included

| File Name     | Description                                              |
|---------------|----------------------------------------------------------|
| `VIEW_GST.sql` | Oracle SQL view integrating GST from transactions & accounting |

---

## 🔍 Key Features

- 📦 **Data Source**:
  - Combines data from:
    - `itemtran_head`, `itemtran_body`
    - `acc_tran`, `view_acc_tran_engine`
    - `stax_mast`, `item_mast`, `acc_mast`
    - `view_address_mast`
  - Uses UNION to handle both invoice-based and account-based GST entries

- 🧾 **GST Segregation**:
  - Distinguishes `SGST`, `CGST`, `IGST`, and `CESS` components
  - Calculates tax **rate** and **amount** dynamically based on:
    - Posting codes
    - Nature of transaction (`tnature`)
    - GST code and structure

- 🧩 **Delivery & Consignee Metadata**:
  - State code, address, GSTIN, PAN
  - Source and destination based GST info
  - Fetches consignee and delivery info via joins to `view_address_mast`

- 🧮 **Tax Logic**:
  - Supports `codefor` flags (`T`, `K`) for identifying the GST type
  - GST post codes pulled using `lhs_utility.get_addon_post_code(...)`
  - Supports GST slab item-rate mapping via `lhs_utility.get_gst_item_rate(...)`

- 📊 **Accounting Transactions**:
  - Entries from `ACC_TRAN` with tax codes also included (e.g., Payment, Journal)
  - Calculates GST allocation via condition-based logic using account codes

---

## 🧑‍💻 Use Cases

- Automated GST Reports for **GSTR-1**, **GSTR-2**, and **GSTR-3B**
- Reconciliation of GST input/output between finance and inventory
- PAN/GSTIN validation between consignee and delivery addresses
- Used in ERP dashboards, GST audit reports, and Excel exports

---

## 🛠️ Technology Stack

- Oracle SQL
- ERP Schema: `itemtran_head`, `acc_tran`, `view_address_mast`
- Functions:
  - `lhs_utility.get_addon_post_code(...)`
  - `lhs_utility.get_gst_item_rate(...)`
  - `lhs_acc.get_revacc_code(...)`

---

## 🔐 Sample Columns

| Column               | Description                                 |
|----------------------|---------------------------------------------|
| `SGST_RATE`          | State GST rate                              |
| `CGST_AMOUNT`        | Central GST amount                          |
| `IGST_RATE`          | Integrated GST rate                         |
| `from_gstin_type`    | Registered / Composition / Unregistered     |
| `Delivery_to_GSTINNO`| Destination GSTIN of customer               |
| `post_code`          | Auto-determined account posting code        |

---

## ✅ Author

**Shubham Kakde**  
ERP GST Reporting Specialist | Oracle SQL Expert | Finance & Compliance Systems

📜 SQL Code Summary (VIEW_GST.sql)
The VIEW_GST is composed of:

First SELECT block from itemtran_head and itemtran_body for transactional GST

Second SELECT block using VIEW_ACC_TRAN_ENGINE for accounting entries

Dynamic GST classification via CASE, utility functions, and tax code mapping

GST-specific subqueries for addresses and state codes

---

## 📜 License

For internal ERP reporting and statutory GST filing purposes only. Ensure data security and PAN/GST masking before external sharing.

---


