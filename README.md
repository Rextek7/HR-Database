# HR-Database
Database for HR department

# Description
### The recruitment department needs to structure their data and analyse their work.
### There are 10 people working in this department and everyone keeps their own personal file with candidates. This is inconvenient, so we need to create a single database.
### The task of department employees is to find the right candidates for open vacancies.
### Vacancies are also posted on hh.ru. 
### Each candidate passes several stages of selection.
### At the final stage he passes the TalentQ test and is checked by the Security Service.

# The purpose of the database
### Improving the efficiency and quality of the recruitment department's work by centralising and structuring ### candidate data and enabling analytics. 

# The main users of the database are:
### - Recruitment staff;
### - Recruiters/HR-specialists responsible for searching and selecting candidates for open vacancies,
### internships and traineeships;
### - Security personnel of the company we are considering:
### - Senior management of the company (e.g. HR director, same HR director) can use the analytics data from the database to make decisions related to recruitment and HR management.
### - Candidates who can receive information on the status of their CV/application through a web portal integrated with the database 

# A list of the main entities of the subject area:

### - Vacancy: contains information about jobs that are open for hire. Attributes can include job title, description, candidate requirements, salary range.
### - Grade: the company initially defines a different grade for each position and therefore it is easier to store them in a separate entity.
### - Location: contains information about the branch in which the position is required.
### - Project: contains information about the project for which the position is required.
### - Role: contains information about the division of the position.
### - Customer: contains information about the manager who has opened the vacancy.
### - Comments: contains clarifying information about the post from users.
### - MVZ: contains information about the department to which the position belongs.
### - Candidate: contains information about the candidates who have applied for the vacancy. Attributes may include name, contact information, CV, education, experience.
### - Past Work: contains information about the company from which the employee came (the company co-operates with many others and is more willing to take from already known companies).
### - Recruit Agency: contains information about which agency offered this candidate.
### - Source: contains information about where the candidate's application came from.
### - TalentQ Check: contains information about the results of the TalentQ test taken by candidates at the final stage of selection. Attributes may include total score, section scores.
### - Security Check: contains information about the SB test taken by candidates at the final stage of selection. Attributes may include the result of the check, comments.
### - HR: contains information about the staff members of the recruitment department. Attributes may include name, position, contact information.
### - Candidate vacancy: contains information about which candidate for which vacancy has sent an offer.
### - Rejection: contains information about which candidate for which vacancy was rejected.

# List of reporting forms:
## - Open Vacancy Reports:
### o List of all open vacancies with information about the position, requirements, terms and conditions.
### o Report on the number of open vacancies by categories and divisions.
### o Report on the dynamics of closing vacancies by candidate for a certain period.
## - Reports on candidates:
### o List of all candidates with their main characteristics.
### o Report on conversion of candidates at different stages of selection (interview applications, offer).
## - Hiring Effectiveness Reports:
### o Report on quality of hiring based on executive satisfaction.
### o Report on recruitment costs for staff and specialists.
### o Report on staff turnover (reasons for resignations, tenure).
## - Analytical reports:
### o Report on labour market trends (changes in supply and demand, average salaries, new working conditions).
## - Personnel management reports:
### o Report on staff structure and dynamics (headcount, changes, subdivisions).

# Logical (infological) model of the subject area in Chen's notation
![image (6)](https://github.com/user-attachments/assets/e67b781c-4602-4bb6-9fc3-4fe9168b86bf)

# Datalogical data model in IDEF1X notation
![hr](https://github.com/user-attachments/assets/57dba810-9ca6-47cd-a3e6-9d5cafa20063)

# Database diagram
![image](https://github.com/user-attachments/assets/4c9c6c3f-0b82-4051-897a-541871caada3)

# Conformities to the third normal form (3NF):
## For a database to conform to third normal form (3NF), the following conditions must be met:
### 1.	First Normal Form (1NF): All columns contain atomic (indivisible) values.
### 2.	Second normal form (2 NF): The table is in 1 NF and all non-key attributes are completely dependent on the primary key.
### 3. third normal form (3 NF): The table is in 2 NFs, and all non-key attributes are not transitively dependent on the primary key (i.e., they do not depend on other non-key attributes).
## In the presented database schema:
### - Attributes are atomic (1 NF): All attributes in tables have atomic values.
### - Primary key dependency (2 NF): All non-key attributes in each table depend on the entire composite key (if any), or on a simple primary key.
### - No transitive dependencies (3 NF): All non-key attributes depend only on the primary key and do not depend on other non-key attributes.
### Thus, the data structure represented in the diagram corresponds to the third normal form (3NF).

# The Python script to populate the table:
Link

### The most complex Select query was also selected (see below). The indexes were configured and the results of the settings were recorded in the report with the query execution time before and after adding the indexes.
Query execution time before / after creating the indexes:
![image](https://github.com/user-attachments/assets/35f684a3-ca75-4cff-aa56-f9a6917abbe8)
### Before. Execution time: 308.051 ms.
		
![image](https://github.com/user-attachments/assets/a60a98f9-f749-4bcd-8a1f-8dd9ef931533)
### After. Execution time: 79.351 ms.

### All necessary documents, namely files with .sql extension and readme, are located in the ‘SQL scripts’ folder. An explanation and description of the main points is also provided for each enquiry

# Reports 
### Reports have a direct link to the task, i.e. they are useful for the subject area [for the recruitment department]. All developed reports are updated when opened or by pressing a button, and also the reports in our work are based on three most interesting queries, which are described in the description of each of the three reports separately.
### All files are located in the ‘Reports’ folder. There are two reports in Power BI and one in Excel. Let's move on to a more detailed study of each of the reports:

## Report #1 (created in Power BI):
### Report #1 is made based on the query ‘aggregate zap.sql’. It provides an analysis of the candidates with details about to get a job. The report itself consists of:
### - Number of candidates;
### - Average expected salary;
### - Chart ‘Distribution of hired/unhired candidates’;
### - Diagram ‘Source of information about the vacancy’;
### - Chart ‘Distribution of candidates by previous positions’;
### - Detail.
## Report №2 (created in Power BI):
### Report #2 is made based on the query ‘join zap.sql’. It presents the analysis of vacancies with drill down and detailing. The report itself consists of:
### - Number of vacancies;
### - Average salary value;
### - Chart ‘Vacancy relevance’;
### - Diagram ‘Number of vacancies by company’;
### - Diagram ‘Average salary by projects’;
### - Detail.
## Report №3 (created in Excel):
### Report #3 is made based on the query ‘having zap.sql’. It shows the distribution of the number of vacancies grouped by projects. There is both a graph and ‘slices’. The peculiarity is that an automatic system of changing the report with changing the data in the database is implemented. The report itself consists of:
### - Sheet ‘Data’ with the source data;
### - Sheet ‘Report 3’ with a summary table, graph and slices.
