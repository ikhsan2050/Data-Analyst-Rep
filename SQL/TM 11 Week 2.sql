CREATE DATABASE Week12_086;
SHOW DATABASES;

-- SOAL 1
USE Week12_086;
CREATE TABLE Tabel1(
	idTrans CHAR(7) NOT NULL,
	Tanggal DATE NOT NULL DEFAULT CURRENT_DATE,
	Total FLOAT NOT NULL,
	Diskon FLOAT NOT NULL,
	Rp_Diskon FLOAT NOT NULL,
	Bayar FLOAT NOT NULL
	)
DESCRIBE Tabel1;

INSERT INTO Tabel1(idTrans, Tanggal, Total)
VALUES
	('tr00001', '20210501', 1000500),
	('tr00002', '20210502', 500000),
	('tr00003', '20210503', 1100000),
	('tr00004', '20210504', 1300000),
	('tr00005', '20210505', 900000),
	('tr00006', '20210506', 1100000),
	('tr00007', '20210506', 250000),
	('tr00008', '20210508', 450000),
	('tr00009', '20210508', 1100000),
	('tr00010', '20210510', 120000)
SELECT * FROM Tabel1;

UPDATE Tabel1 SET Diskon = 5 WHERE Total >= 500000
UPDATE Tabel1 SET Diskon = 10 WHERE Total >= 1000000
SELECT * FROM Tabel1;

UPDATE Tabel1 SET Rp_Diskon = (Total * Diskon / 100)
SELECT * FROM Tabel1;

UPDATE Tabel1 SET Bayar = (Total - Rp_Diskon)
SELECT * FROM Tabel1;

-- SOAL 2
CREATE TABLE Dosen(
	NID VARCHAR(8) NOT NULL,
	Nama_Dosen VARCHAR(25),
	JK_Dosen CHAR(1),
	Alamat_Dosen VARCHAR(25),
	Kota VARCHAR(15),
	Telp VARCHAR(12),
	PRIMARY KEY (NID)
	)
DESCRIBE Dosen;

CREATE TABLE MataKuliah(
	KDMK VARCHAR(4) NOT NULL,
	Nama_MK VARCHAR(25),
	SKS INT,
	Semester INT,
	PRIMARY KEY (KDMK)
	)
DESCRIBE MataKuliah

CREATE TABLE Mengajar(
	NID VARCHAR(8) NOT NULL,
	KDMK VARCHAR(4) NOT NULL,
	Hari VARCHAR(6),
	Jam_Ke VARCHAR(4),
	Kelas VARCHAR(15),
	FOREIGN KEY (NID) REFERENCES Dosen (NID),
	FOREIGN KEY (KDMK) REFERENCES MataKuliah (KDMK)
	)
DESCRIBE Mengajar

INSERT INTO Dosen(NID, Nama_Dosen, JK_Dosen, Alamat_Dosen, Kota, Telp)
VALUES
	('19840621', 'Army', 'P', 'Kebomas', 'Gresik', '085635127362'),
	('19820404', 'Indah', 'P', 'Dupak', DEFAULT, '031346574546'),
	('19800212', 'Taufik', 'L', NULL, NULL, NULL)
SELECT * FROM Dosen;

INSERT INTO MataKuliah(KDMK, Nama_MK, SKS, Semester)
VALUES
	('SI01', 'Pengantar Teknologi Informasi', 2, 1),
	('BD01', 'Basis Data', 2, 2),
	('BD02', 'Managemen Basis Data', 2, 3)
SELECT * FROM MataKuliah;

INSERT INTO Mengajar(NID, KDMK, Hari, Jam_Ke, Kelas)
VALUES
	('19820404', 'BD01', 'Senin', '7-8', 'Labkomp 1'),
	('19800212', 'BD01', 'Senin', '7-8', 'Labkomp 2'),
	('19840621', 'BD02', 'Selasa', '5-6', 'Labkomp 1'),
	('19800212', 'BD02', 'Selasa', '3-4', 'Labkomp 1'),
	('19800212', 'SI01', 'Senin', '1-2', '306')
SELECT * FROM Mengajar;

UPDATE Mengajar SET Hari = 'Kamis' WHERE NID = '19820404'
SELECT * FROM Mengajar;

UPDATE Mengajar SET Kelas = 'Labkomp 1' WHERE KDMK = 'BD01'
SELECT * FROM Mengajar;

DELETE FROM Mengajar WHERE KDMK = 'SI01'
SELECT * FROM Mengajar;

ALTER TABLE Mengajar DROP CONSTRAINT mengajar_ibfk_2
DELETE FROM MataKuliah WHERE KDMK = 'BD01'
SELECT * FROM MataKuliah;

DELETE FROM MataKuliah WHERE KDMK = 'SI01'
SELECT * FROM MataKuliah;

DELETE FROM Mengajar
SELECT * FROM Mengajar;

DELETE FROM Dosen WHERE NID = '1234'
SELECT * FROM Dosen

SHOW CREATE TABLE Mengajar
SHOW INDEX FROM Mengajar