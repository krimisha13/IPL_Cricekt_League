
---

## 🛠️ Tools Used

- **SQL Server Integration Services (SSIS)** – ETL process
- **Microsoft SQL Server** – Database backend
- **SQL Server Management Studio (SSMS)** – Query execution and validation
- **Visual Studio 2022** – SSIS package development
- **CSV/Excel** – Data source

---

## 🧩 Key Features

- Full ETL pipeline using SSIS
- Incremental data loading
- Data validation with **Conditional Split**, **Lookup**, and **Derived Column**
- Error handling with **Ipl_ErrorLog** table
- Star schema data model for analytical workloads
- Complete SQL DDL and project documentation

---

## 🧮 ETL Flow Summary

- **Extract**: CSV files loaded using Flat File Sources
- **Transform**: 
  - Null checks and FK validation using Conditional Split and Lookups
  - Derived Columns used to handle inconsistent City/ID mapping
- **Load**: Final data inserted into normalized Dimension and Fact tables
- **Log**: Invalid rows logged into `Ipl_ErrorLog` for data correction

---

## 🗃️ Database Schema Overview

The data warehouse follows a **Star Schema** design, including:

- **Dimension Tables**: `Dim_Player`, `Dim_Team`, `Dim_City`, `Dim_Venue`, etc.
- **Fact Tables**: `Fact_Match`, `Fact_Ball_by_Ball`, `Fact_Player_Match`, etc.
- **Error Log Table**: `Ipl_ErrorLog` for tracking invalid data

---

## 📸 Screenshots

| Control Flow | Data Flow | Data Model |
|--------------|-----------|------------|
| ![Control Flow](https://github.com/krimisha13/IPL_Cricket/blob/main/Screenshots/Control%20Flow%20Image%201.png)
| ![Data Flow](https://github.com/krimisha13/IPL_Cricket/blob/main/Screenshots/Data%20Flow%20TaskImage%201.png)
| ![Data Model](https://github.com/krimisha13/IPL_Cricket/blob/main/Screenshots/Data%20Modeling.png) |

---

## 📄 Documentation

The full project report is available in the Ipl Cricket. It includes:
- ETL Design
- Schema Design
- Data Quality Rules
- Error Handling Strategy
- SQL Tasks & Outputs
- Challenges and Solutions

---

## 📥 How to Run

1. Open the SSIS project in **Visual Studio 2022**
2. Update file paths in Flat File Connection Managers if needed
3. Execute the SSIS packages for dimension and fact table loading
4. Review data in SQL Server using SSMS

---

## 📧 Author

**Krimisha Vaghela** 

---


