CREATE TABLE Employees (
    Emp_no      INT             NOT NULL,
    First_name  VARCHAR(15)     NOT NULL,
    Last_name   VARCHAR(15)     NOT NULL,
    Address     VARCHAR(15)     NOT NULL,
    Gender      ENUM ('M','F')  NOT NULL, 
    Birth_date  DATE            NOT NULL,   
    Hire_date   DATE            NOT NULL,
    PRIMARY KEY (Emp_no)
    );
    
    CREATE TABLE Departments (
    Dept_no     VARCHAR(15)      NOT NULL,
    Dept_name   VARCHAR(15)     NOT NULL,
    PRIMARY KEY (Dept_no),
    UNIQUE  KEY (Dept_name)
);
CREATE TABLE Dept_Manager (
   Emp_no       INT             NOT NULL,
   Dept_no      VARCHAR(15)     NOT NULL,
   From_date    DATE            NOT NULL,
   To_date      DATE            NOT NULL,
   FOREIGN KEY (Emp_no)  REFERENCES Employees (Emp_no)    ON DELETE CASCADE,
   FOREIGN KEY (Dept_no) REFERENCES Departments (Dept_no) ON DELETE CASCADE,
   PRIMARY KEY (Emp_no,Dept_no)
);

CREATE TABLE Dept_Emp (
    Emp_no      INT             NOT NULL,
    Dept_no     VARCHAR(15)     NOT NULL,
    From_date   DATE            NOT NULL,
    To_date     DATE            NOT NULL,
    FOREIGN KEY (Emp_no)  REFERENCES Employees   (Emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (Dept_no) REFERENCES Departments (Dept_no) ON DELETE CASCADE,
    PRIMARY KEY (Emp_no,Dept_no)
);
CREATE TABLE Titles (
    Emp_no      INT             NOT NULL,
    Title       VARCHAR(15)     NOT NULL,
    From_date   DATE            NOT NULL,
    To_date     DATE,
    FOREIGN KEY (Emp_no) REFERENCES Employees (Emp_no) ON DELETE CASCADE,
    PRIMARY KEY (Emp_no,Title, From_date)
) ; 

CREATE TABLE Salaries (
    Emp_no      INT             NOT NULL,
    Salary      INT             NOT NULL,
    From_date   DATE            NOT NULL,
    To_date     DATE            NOT NULL,
    FOREIGN KEY (Emp_no) REFERENCES Employees (Emp_no) ON DELETE CASCADE,
    PRIMARY KEY (Emp_no, From_date)
) ;


CREATE OR REPLACE VIEW Dept_Emp_latest_date AS
    SELECT Emp_no, MAX(From_date) AS From_date, MAX(To_date) AS To_date
    FROM Dept_Emp
    GROUP BY Emp_no;
    
    
 CREATE OR REPLACE VIEW Current_Dept_Emp AS
    SELECT l.Emp_no, Dept_no, l.From_date, l.To_date
    FROM Dept_Emp d
        INNER JOIN Dept_Emp_latest_date l
        ON d.Emp_no=l.Emp_no AND d.From_date=l.From_date AND l.To_date = d.To_date;