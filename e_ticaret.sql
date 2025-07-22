
CREATE TABLE Musteriler (
    MusteriID INT PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    Email VARCHAR(100),
    Telefon VARCHAR(15)
);

CREATE TABLE Urunler (
    UrunID INT PRIMARY KEY,
    UrunAdi VARCHAR(100),
    Fiyat DECIMAL(10,2),
    StokMiktari INT
);

CREATE TABLE Siparisler (
    SiparisID INT PRIMARY KEY,
    MusteriID INT,
    Tarih DATE,
    ToplamTutar DECIMAL(10,2),
    FOREIGN KEY (MusteriID) REFERENCES Musteriler(MusteriID)
);

CREATE TABLE SiparisDetaylari (
    SiparisDetayID INT PRIMARY KEY,
    SiparisID INT,
    UrunID INT,
    Adet INT,
    FOREIGN KEY (SiparisID) REFERENCES Siparisler(SiparisID),
    FOREIGN KEY (UrunID) REFERENCES Urunler(UrunID)
);

CREATE TABLE Calisanlar (
    CalisanID INT PRIMARY KEY,
    Ad VARCHAR(50),
    Soyad VARCHAR(50),
    Departman VARCHAR(50)
);


INSERT INTO Musteriler VALUES (1, 'Ahmet', 'Yılmaz', 'ahmet@gmail.com', '05001234567');
INSERT INTO Musteriler VALUES (2, 'Ayşe', 'Kara', 'ayse@gmail.com', '05007654321');

INSERT INTO Urunler VALUES (1, 'Laptop', 15000, 5);
INSERT INTO Urunler VALUES (2, 'Mouse', 250, 10);

INSERT INTO Siparisler VALUES (1, 1, '2025-07-01', 15250);
INSERT INTO SiparisDetaylari VALUES (1, 1, 1, 1);
INSERT INTO SiparisDetaylari VALUES (2, 1, 2, 1);

INSERT INTO Calisanlar VALUES (1, 'Emre', 'Demir', 'Satış');
INSERT INTO Calisanlar VALUES (2, 'Selin', 'Koç', 'Destek');


 1. Müşterilerin siparişlerini getir
SELECT m.Ad, m.Soyad, s.SiparisID, s.Tarih, s.ToplamTutar
FROM Musteriler m
JOIN Siparisler s ON m.MusteriID = s.MusteriID;

2. En çok satılan ürünler
SELECT u.UrunAdi, SUM(sd.Adet) AS ToplamSatis
FROM SiparisDetaylari sd
JOIN Urunler u ON sd.UrunID = u.UrunID
GROUP BY u.UrunAdi
ORDER BY ToplamSatis DESC;
 3. Stokta kalmayan ürünleri getir
SELECT * FROM Urunler WHERE StokMiktari = 0;
