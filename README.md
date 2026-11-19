<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/2612541e-e4bb-43d5-807d-77285309521c" />


# WMIC-Fixed (Windows 11 26H2+)

สคริปต์ PowerShell แบบ One-Liner สำหรับติดตั้ง **WMIC (Windows Management Instrumentation Command-line)** กลับคืนสู่ระบบปฏิบัติการ **Windows 11 Version 26H2** ขึ้นไป โดยดาวน์โหลดแพ็กเกจต้นฉบับตรงจากเซิร์ฟเวอร์ของ Microsoft

---

## 📌 ที่มาของโปรเจกต์ (Background)

ตั้งแต่ **Windows 11 Version 26H2 (Build 26300+)** เป็นต้นมา Microsoft ได้ดำเนินการตัด **WMIC** ออกจากตัว Image ของ Windows อย่างถาวร

ก่อนหน้านี้ในเวอร์ชัน **24H2 / 25H2** ช่างเทคนิคและผู้ดูแลระบบยังสามารถใช้ไฟล์ `unattend.xml` หรือคำสั่ง DISM เพื่อคงสถานะของ WMIC เอาไว้ได้ แต่ใน **26H2** ไฟล์ของ WMIC ถูกลบออกจาก Image โดยสมบูรณ์ ทำให้คำสั่งเก่าไม่สามารถใช้งานได้อีกต่อไป และส่งผลให้สคริปต์ Batch, เครื่องมือซ่อมบำรุง หรือโปรแกรมรุ่นเก่าที่ยังเรียกใช้ `wmic` เกิดข้อผิดพลาด `'wmic' is not recognized as an internal or external command`

โปรเจกต์ **WMIC-Fixed** จึงถูกสร้างขึ้นเพื่อให้สามารถดึงแพ็กเกจ WMIC อย่างเป็นทางการจาก Microsoft มาติดตั้งและคอมไพล์ลงระบบใหม่ได้ภายในคำสั่งเดียว สะดวก รวดเร็ว และปลอดภัย

---

## ✨ คุณสมบัติ (Features)

- **Official Direct Download:** ดาวน์โหลดไฟล์ `wmic_dlc.zip` ตรงจากเซิร์ฟเวอร์ของ Microsoft (`download.microsoft.com`) ไม่มีการฝากไฟล์ Binary ดัดแปลงไว้บน GitHub
- **One-Line Execution:** ติดตั้งจบในคำสั่งเดียวผ่าน PowerShell รองรับการใช้งานทั้งหน้า Desktop ปกติ และระหว่างการ Setup ระบบ
- **Auto Privilege & Status Check:** ตรวจสอบสิทธิ์ Administrator และตรวจสอบสถานะการติดตั้งให้อัตโนมัติ
- **Bypass & Unblock:** จัดการปลดล็อกไฟล์ (`Unblock-File`) และรันตัวติดตั้ง `install.ps1` ของ Microsoft พร้อมคอมไพล์ไฟล์ MOF (`cli.mof`, `cliegaliases.mof`) ให้อัตโนมัติ
- **Auto Cleanup:** ลบไฟล์ชั่วคราวและโฟลเดอร์ติดตั้งใน `%TEMP%` ทิ้งทันทีหลังทำงานเสร็จ ไม่ทิ้งไฟล์ขยะไว้ในเครื่อง
- **Instant Verification:** ทดสอบเรียกใช้งานคำสั่ง `wmic os get caption` ทันทีหลังติดตั้งเสร็จเพื่อยืนยันว่าพร้อมใช้งาน

> **Verified on:** Windows 11 Version 26H2 (OS Build 26300.9457)

---

## 🚀 วิธีใช้งาน (Usage)

1. เปิด **PowerShell** หรือ **Windows Terminal** ด้วยสิทธิ์ **Run as Administrator**
2. คัดลอกคำสั่งด้านล่างไปวางแล้วกด **Enter**

### แบบลิงก์ย่อ (แนะนำ)
```powershell
iex (irm bit.ly/wmicfix)
```

### แบบลิงก์ตรงจาก GitHub
```powershell
iex (irm https://raw.githubusercontent.com/itgroceries-sudo/WMIC-Fixed/main/Install.ps1)
```

3. รอสักครู่จนหน้าจอแสดงข้อความ `[SUCCESS] WMIC installed successfully!` พร้อมแสดงชื่อรุ่นของ Windows ถือเป็นอันเสร็จสมบูรณ์

<details>
  <summary>Click to View UI</summary>
<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/0707918b-347b-492e-b793-0ff484777b0d" />
</details>


---

## ⚠️ หมายเหตุ (Notes)

- เครื่องที่รันสคริปต์จำเป็นต้องเชื่อมต่ออินเทอร์เน็ตเพื่อดาวน์โหลดแพ็กเกจจาก Microsoft
- หากนำไปรันบน **Windows 11 24H2 / 25H2** ที่มี WMIC เดิมอยู่ในระบบอยู่แล้ว สคริปต์จะตรวจสอบและแจ้งเตือนโดยไม่เขียนทับไฟล์ระบบเดิม

---

## 👨‍💻 เครดิตและช่องทางติดตาม (Credits & Contact)

พัฒนาและดูแลโดย **IT Groceries Shop**

- **GitHub:** [itgroceries-sudo](https://github.com/itgroceries-sudo)
- **Facebook:** [Adm1n1straTOE](https://www.facebook.com/Adm1n1straTOE/)
- **YouTube:** [@itgroceries](https://www.youtube.com/@itgroceries)

*ขอขอบคุณแพ็กเกจ WMIC DLC ต้นฉบับจาก Microsoft*

---

## 📄 License

โปรเจกต์นี้เผยแพร่ภายใต้สัญญาอนุญาต [MIT License](LICENSE) — สามารถนำไปใช้งาน ดัดแปลง หรือแจกจ่ายต่อได้โดยอิสระ
````[cite: 4]
