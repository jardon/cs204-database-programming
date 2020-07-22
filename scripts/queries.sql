SELECT * FROM clients;

SELECT ClientFirstName, ClientLastName, YEAR(CURDATE()) - ClientDob AS Age, Occupation FROM clients; 

SELECT ClientFirstName, ClientLastName FROM clients WHERE ClientId IN (
    SELECT ClientId FROM borrowers WHERE BorrowDate >= Date('2018-03-01') AND BorrowDate <= Date('2018-03-31'));