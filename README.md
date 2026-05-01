# 🛠️ PowerShell Utilities

> Scripts designed to automate and streamline routine tasks in corporate Service Desk and IT Infrastructure environments.

---

## 📁 Scripts Overview

### `Helpdesk_utilities.bat` — Interactive Helpdesk Menu
A command-line menu tool built for frontline IT support. Centralizes the most common Level 1/2 support actions into a single interface, reducing resolution time and minimizing human error.

**Features:**
- Clear temporary files (Temp, Prefetch, Store cache)
- Repair Microsoft Edge, Google Chrome, and Microsoft Teams (cache clear + process kill)
- Restart Windows Audio services
- Force Group Policy update (`gpupdate /force`)
- Network diagnostics submenu: `ipconfig /all`, DNS flush, ping, route table, Winsock reset
- Trigger Windows Update via `UsoClient`
- DISM image repair and component cleanup (runs in a separate PowerShell window)
- Active session listing and remote logoff via `quser` / `logoff`

---

### `AD_Group_Data_Import_to_Csv.ps1` — AD Group Member Export
Exports detailed user data from an Active Directory security group to a structured `.csv` file. Useful for HR audits, access reviews, and compliance reporting.

**Exported fields:** `SamAccountName`, `DisplayName`, `EmailAddress`, `LastLogonDate`, `Company`, `Department`, `Title`, `City`, `Office`, `Description`

**Usage:**
```powershell
# Edit the $grupo variable with the target group name, then run:
.\AD_Group_Data_Import_to_Csv.ps1
# Output: C:\Group_data_sheet.csv
```

---

### `AD_user_group_membership.ps1` — User Group Membership Export
Lists all Active Directory groups a specific user belongs to and exports the result to a `.txt` file. Useful for access audits and offboarding workflows.

**Usage:**
```powershell
# Edit the $usuario variable with the target username, then run:
.\AD_user_group_membership.ps1
# Output: C:\<username>.txt
```

---

### `Check-ADAttribute.ps1` — AD Attribute Conflict Checker
Scans Active Directory for duplicate values in a specified user attribute. Designed to support HR data audits and resolve synchronization conflicts (e.g., with Azure AD Connect / Entra ID sync).

**Usage:**
```powershell
.\Check-ADAttribute.ps1 -AttributeName "employeeID" -SearchValue "1100289011"
```

**Output examples:**
- 🔴 `Found 2 duplicates!` — lists conflicting accounts in a formatted table
- 🟢 `Unique value in AD.` — confirms no conflict
- 🟡 `No user found with this value.`

---

## ⚙️ Requirements

- Windows PowerShell 5.1+ or PowerShell 7+
- `ActiveDirectory` module (RSAT — Remote Server Administration Tools)
- Domain-joined machine with appropriate read permissions on AD
- Administrator privileges recommended for `Helpdesk_utilities.bat`

---

## 👤 Author

**Lorenzo Moreira** — IT Infrastructure & Support Specialist  
[LinkedIn](https://www.linkedin.com/in/lorenzomoreira12) · [GitHub](https://github.com/lorenzomoreira12)
