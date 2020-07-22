CREATE TABLE authors(
    AuthorId INT AUTO_INCREMENT,
    AuthorFirstName VARCHAR(100),
    AuthorLastName VARCHAR(100),
    AuthorNationality VARCHAR(50),
    AuthorDoB DATE,
    PRIMARY KEY(AuthorId)
);

CREATE TABLE books(
    BookID INT AUTO_INCREMENT,
    BookTitle VARCHAR(100),
    BookAuthor INT,
    Genre VARCHAR(50),
    PRIMARY KEY(BookID),
    FOREIGN KEY(BookAuthor) REFERENCES authors(AuthorId)
);

CREATE TABLE clients(
    ClientId INT AUTO_INCREMENT,
    ClientFirstName VARCHAR(100),
    ClientLastName VARCHAR(100),
    ClientDoB SMALLINT,
    Occupation VARCHAR(50),
    PRIMARY KEY(ClientId)
);

CREATE TABLE borrowers(
    BorrowId INT AUTO_INCREMENT,
    ClientId INT,
    BookId INT,
    BorrowDate DATE,
    PRIMARY KEY(BorrowId),
    FOREIGN KEY(ClientId) REFERENCES clients(ClientId),
    FOREIGN KEY(BookId) REFERENCES books(BookID)
);