-- SELECT nom_p FROM Produit WHERE origine='Dijon';

-- SELECT nom_f,FE.f from Fourniture AS FE , Produit AS P, Fournisseur AS FR where FE.f = FR.f AND FE.p = P.p AND nom_p = 'salade';

-- SELECT p from Fourniture join Fournisseur using(f) where ville = 'Paris';

-- SELECT DISTINCT nom_f, remise from Produit JOIN Fourniture using(p) JOIN Fournisseur using(f)  where origine='Dijon';

-- SELECT nom_p from Fourniture join Produit using(p) join Fournisseur using(f) where nom_f='Bornibus' AND qte < 5;

SELECT F2.nom_f , F2.ville from Fournisseur F1, Fournisseur as F2 WHERE F1.remise < F2.remise and F1.nom_f = 'Bornibus';

-- explain query plan select nom_f,nom_p from Fournisseur fs, Produit p, Fourniture ft where fs.f=ft.f and p.p=ft.p;
