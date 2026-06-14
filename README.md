# Employee Management System (EMS)

A web-based Employee Management System developed using **Java Servlets, JSP, JDBC, MySQL, JSTL, and Apache Tomcat**. The application provides secure role-based authentication, employee management, automated credential generation, email notifications, and a responsive admin dashboard.

## Snapshot (On Mobile - Login Screen)
<img width="585" height="848" alt="IMG_7031" src="https://github.com/user-attachments/assets/7f02042a-22be-4427-9c7b-178fe78176ff" />

## Features

### Authentication & Authorization

* Role-based login (Admin / Employee)
* Login using Employee ID or Email
* Session-based authentication
* Secure access control for protected pages

### Admin Features

* View employee directory
* Add new employees
* Edit employee information
* Delete employees
* Prevent self-deletion of the active admin account
* Auto-generated Employee IDs
* Auto-generated temporary passwords
* Employee credential delivery via email
* Server-side pagination
* Sorting by:

  * Employee ID
  * Name
  * Department
  * Salary

### Employee Features

* View personal profile
* Read-only employee information page

### Password Recovery

* Retrieve credentials using Employee ID or Email
* Automated email delivery using JavaMail

### User Interface

* Tailwind CSS based responsive design
* Mobile-friendly layout
* Modern dashboard and forms
* Color-coded success and error messages

---

## Technology Stack

### Backend

* Java (JDK 21+)
* Java Servlets
* JSP (Java Server Pages)
* JDBC

### Frontend

* HTML5
* Tailwind CSS
* JSTL

### Database

* MySQL

### Server

* Apache Tomcat 9

### Additional Libraries

* MySQL Connector/J
* JavaMail API
* JSTL

---

## Project Structure

```text
EmployeeManagementSystem/

src/
└── com/ems/
    ├── controller/
    │   ├── LoginServlet.java
    │   ├── LogoutServlet.java
    │   ├── AdminDashboardServlet.java
    │   ├── AddEmployeeServlet.java
    │   ├── EditEmployeeServlet.java
    │   ├── DeleteEmployeeServlet.java
    │   └── ForgotPasswordServlet.java
    │
    ├── dao/
    │   └── EmployeeDAO.java
    │
    ├── model/
    │   └── Employee.java
    │
    └── util/
        ├── DBConnection.java
        ├── ConfigUtil.java
        ├── EmailUtil.java
        └── PasswordUtil.java

WebContent/
├── WEB-INF/
│   ├── classes/
│   │   ├──config.properties
│   │   └──config.properties.example
│   │
│   ├── lib/
│   │   ├── mysql-connector-j-9.6.0.jar
│   │   ├── javax.mail.jar
│   │   ├── activation-1.1.1.jar
│   │   ├── jstl-1.2.jar
│   │   └── standard-1.1.2.jar
│   │
│   └── web.xml
│
├── login.jsp
├── forgot_password.jsp
├── admin_dashboard.jsp
├── add_employee.jsp
├── edit_employee.jsp
└── employee_profile.jsp

README.md
```

---

## Database Schema

### Employees Table

```sql
CREATE TABLE employees (
    employee_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    salary DECIMAL(10,2),
    role ENUM('Admin','Employee') DEFAULT 'Employee',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Default Admin Account

```sql
INSERT INTO employees
(employee_id, name, email, password, department, salary, role)
VALUES
('ADMIN001',
 'System Administrator',
 'admin@company.com',
 'Admin@123',
 'Management',
 0,
 'Admin');
```

---

## Configuration

Create a file named:

```text
config.properties
```

inside:

```text
WebContent/WEB-INF/classes/
```

Example:

```properties
EMAIL_USER=your-email@gmail.com
EMAIL_PASS=your-app-password

DB_URL=jdbc:mysql://localhost:3306/yourdbname
DB_USER=root
DB_PASS=your_mysql_password
```

**Important:** Never commit the actual `config.properties` file to GitHub.

---

## Running the Project

### Prerequisites

* JDK 21+
* Apache Tomcat 9
* MySQL Server
* Eclipse IDE (Enterprise Java / Web Developer Edition)

### Steps

1. Clone the repository.
2. Create the MySQL database.
3. Execute the schema SQL.
4. Configure `config.properties`.
5. Add required JAR files to `WEB-INF/lib`.
6. Deploy the project on Apache Tomcat.
7. Access:

```text
http://localhost:8080/EmployeeManagementSystem
```

---

## WAR Deployment

Export the application as:

```text
EmployeeManagementSystem.war
```

Copy the WAR file to:

```text
apache-tomcat-9.x/webapps/
```

Start Tomcat and access:

```text
http://localhost:8080/EmployeeManagementSystem
```

---

## Snapshots of Project (PC)


## Login Screen
<img width="856" height="914" alt="image" src="https://github.com/user-attachments/assets/cf258439-ac3c-4f6b-ad4a-ce7468a0dbd4" />

## Admin Dashboard
<img width="948" height="663" alt="dashboard" src="https://github.com/user-attachments/assets/e04a725f-dea3-4799-b389-61264e05a1a0" />

## Add Employee
<img width="948" height="920" alt="add-employee" src="https://github.com/user-attachments/assets/8d8ec3d2-7a75-4bde-a581-610a5d2b1664" />

## Credential Email
<img width="1257" height="677" alt="image" src="https://github.com/user-attachments/assets/23a1e4c0-f9b0-4c02-959d-5183cffd7826" />


## Add Employee Dashboard Message
<img width="950" height="802" alt="add-employee-dashboard" src="https://github.com/user-attachments/assets/76e5b3ad-b795-4d9e-93dc-6ca39963226c" />

## Employee Dashboard
<img width="942" height="882" alt="employee_dashboard" src="https://github.com/user-attachments/assets/52303e2a-8b93-462f-9a5b-5eaba1817aad" />


## Security Notes

* Sensitive credentials are stored outside source code.
* Session-based authentication is implemented.
* Admin self-deletion is prevented.
* Configuration values are excluded from version control.

---

## Future Enhancements

* Password hashing using BCrypt
* Change Password functionality
* Employee search and filtering
* Dashboard analytics
* Profile image support
* Audit logs
* Cloud deployment support

---

## Author

**Akash Karmakar**

Bachelor of Computer Applications (BCA)
The Heritage Academy, Kolkata

---

## License
MIT License
This project is developed for academic and educational purposes.
