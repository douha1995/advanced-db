# Advanced Database Course

[![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=flat&logo=microsoft-sql-server&logoColor=white)](https://www.microsoft.com/en-us/sql-server)

> Course materials and SQL examples for Advanced Database concepts using SQL Server and BikeStore sample database.

## 📺 Course Resources

- **YouTube Playlist:** [Watch Lectures](https://www.youtube.com/playlist?list=PLH1DHVpguI_L72ao8wCXfKswVvLmfGsM5)

## 📋 Prerequisites

- SQL Server installed (2019 or later recommended)
- [BikeStore Sample Database](https://www.sqlservertutorial.net/sql-server-sample-database/)
- Basic SQL knowledge (SELECT, INSERT, UPDATE, DELETE)

## 📚 Topics Covered

| Topic | Description | Example File |
|-------|-------------|--------------|
| **Stored Procedures** | Creating, modifying, parameters, output | [procedures.sql](examples/procedures.sql) |
| **SQL Cursors** | DECLARE, OPEN, FETCH, CLOSE, DEALLOCATE | [cursors.sql](examples/cursors.sql) |
| **Error Handling** | TRY-CATCH blocks, error functions | [cursors.sql](examples/cursors.sql) |
| **User-Defined Functions** | Scalar functions, table variables | [functions.sql](examples/functions.sql) |
| **Indexes** | Clustered & non-clustered indexes | [indexes.sql](examples/indexes.sql) |
| **Triggers** | DML triggers, INSERTED/DELETED tables | [triggers.sql](examples/triggers.sql) |

## 📁 Repository Structure

```
advanced-db/
├── README.md
├── examples/           # SQL code examples from lectures
│   ├── cursors.sql
│   ├── functions.sql
│   ├── indexes.sql
│   ├── procedures.sql
│   └── triggers.sql
└── sheets/             # Practice exercises
    ├── stored-procedures-cursors.md
    └── views-indexes.md
```

## 📝 Practice Sheets

| Sheet | Topics |
|-------|--------|
| [Stored Procedures & Cursors](sheets/stored-procedures-cursors.md) | Procedures with parameters, WHILE loops, cursors |
| [Views & Indexes](sheets/views-indexes.md) | Index optimization, creating views, performance |

## 🚀 Getting Started

1. Install SQL Server and restore BikeStore database
2. Open SQL files in SSMS
3. Execute examples section by section
4. Complete practice sheets for hands-on experience

## 📄 License

Educational materials for Advanced Database course.
