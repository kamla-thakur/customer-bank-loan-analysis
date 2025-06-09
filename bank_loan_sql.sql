Drop database bank_loan_project;

CREATE DATABASE bank_loan_project;

SELECT * FROM bank_loan_project.finance_1;

SELECT * FROM bank_loan_project.finance_2;

# (1) KPI Year wise loan amount 

SELECT 
    YEAR(issue_d) AS Year_of_issue_d,
    SUM(loan_amnt) AS Total_loan_amnt
FROM
    bank_loan_project.finance_1
GROUP BY Year_of_issue_d
ORDER BY Year_of_issue_d
LIMIT 0 , 2000;

# (2) KPI

SELECT 
    grade, sub_grade, SUM(revol_bal) AS total_revol_bal
FROM
    bank_loan_project.finance_1
        INNER JOIN
    bank_loan_project.finance_2 ON (finance_1.id = finance_2.id)
GROUP BY grade , sub_grade
ORDER BY grade , sub_grade;

# (3) KPI

SELECT 
    f1.verification_status,
    ROUND(SUM(f2.total_pymnt), 2) AS total_pymnt
FROM
    bank_loan_project.finance_1 as f1
        INNER JOIN
    bank_loan_project.finance_2 as f2 ON (f1.id = f2.id)
GROUP BY verification_status
Limit 2000;


SELECT * FROM bank_loan_project.finance_1;

SELECT * FROM bank_loan_project.finance_2;


#(4) KPI

SELECT 
    addr_state, loan_status, COUNT(*) AS count_of_loans_status
FROM
    bank_loan_project.finance_1
        INNER JOIN
    bank_loan_project.finance_2 ON (finance_1.id = finance_2.id)
GROUP BY bank_loan_project.finance_1.addr_state , bank_loan_project.finance_1.loan_status;
        
# (5) KPI

SELECT 
    MONTH(finance_1.issue_d) AS loan_month,
    finance_1.loan_status,
    COUNT(*) AS count_of_loans
FROM
    bank_loan_project.finance_1
        INNER JOIN
    bank_loan_project.finance_2 ON finance_1.id = finance_2.id
GROUP BY loan_month , finance_1.loan_status
ORDER BY loan_month , finance_1.loan_status;

-- Month wise loan status

SELECT 
    last_credit_pull_d, MAX(loan_status) AS loan_status
FROM
    Finance_1
        INNER JOIN
    Finance_2 ON Finance_1.id = Finance_2.id
GROUP BY last_credit_pull_d
ORDER BY last_credit_pull_d;


-- Get more insights based on your understanding of the data---------------------------------------------------------------------------------------------------------------------
-- Home ownership vs Last payment date stats-------------------------------------------------------------------------------------------------------------------------------------


SELECT 
    home_ownership,
    last_pymnt_d,
    CONCAT('$',
            FORMAT(ROUND(SUM(last_pymnt_amnt) / 10000, 2),
                2),
            'K') AS total_payment
FROM
    Finance_1
        INNER JOIN
    Finance_2 ON (Finance_1.id = Finance_2.id)
GROUP BY home_ownership , last_pymnt_d
ORDER BY home_ownership , last_pymnt_d; 
