drop schema if exists onchange_select;
create schema onchange_select;
use onchange_select;

create table suppliers
(
  id         char(36) unique primary key,
  name       varchar(192) unique,
  created_at timestamp default current_timestamp
) engine = InnoDB;

insert into suppliers(id, name)
values ('e922f552-c8f6-4544-beed-17e92bd06f3d', 'Porto Editora'),
       ('0e26426f-ba69-4d71-8ad7-fc775399efa2', 'LeYa'),
       ('a1f0f953-fdd4-4735-8a60-f9da5987f39a', 'Editorial Presença'),
       ('eafd2146-1623-4dd7-aca4-539e777aa0b4', 'Gradiva');

create table categories
(
  id          char(36) unique primary key,
  name        varchar(192),
  fk_supplier char(36),
  created_at  timestamp default current_timestamp,

  constraint foreign key (fk_supplier) references suppliers (id)
) engine = InnoDB;

insert into categories(id, fk_supplier, name)
values ('d32f9e34-ec51-4334-9461-294f42f1e122', 'e922f552-c8f6-4544-beed-17e92bd06f3d', 'Novidades'),
       ('81962811-4bbe-4cb5-9a24-a5e40be43814', 'e922f552-c8f6-4544-beed-17e92bd06f3d', 'eBooks'),
       ('945982c9-11b8-4a27-b04d-82e7baa20117', 'e922f552-c8f6-4544-beed-17e92bd06f3d', 'Best Sellers'),
       ('c0e3599a-a8cf-4d67-85cc-bb2910f68c1c', 'e922f552-c8f6-4544-beed-17e92bd06f3d', 'Audio Livros'),

       ('45c59a7c-389e-4a62-ba76-612e8d352b56', '0e26426f-ba69-4d71-8ad7-fc775399efa2', 'Artigos Acadêmicos'),
       ('e458c882-3584-4a24-998b-dc07e94d0dcb', '0e26426f-ba69-4d71-8ad7-fc775399efa2', 'Audio Livros'),
       ('79bcf182-07db-43bc-b4bc-00616b2ceaa5', '0e26426f-ba69-4d71-8ad7-fc775399efa2', 'eBooks'),
       ('5e7d4291-1edf-4566-b450-81e34b5c4daf', '0e26426f-ba69-4d71-8ad7-fc775399efa2', 'Livros'),

       ('e8fdbec0-6c91-4500-a368-8a9bc9f55129', 'a1f0f953-fdd4-4735-8a60-f9da5987f39a', 'Manuais Digitais'),
       ('febf2d9a-43a0-4c8a-bb2b-f90b953b23cf', 'a1f0f953-fdd4-4735-8a60-f9da5987f39a', 'Audio Livros'),
       ('543b2013-4967-4ba5-b443-0ed8df6e86b1', 'a1f0f953-fdd4-4735-8a60-f9da5987f39a', 'eBooks'),
       ('dafade2e-984f-4cb8-bbb5-85b4c8b61268', 'a1f0f953-fdd4-4735-8a60-f9da5987f39a', 'Livros'),

       ('f12fc6d6-03ac-47dd-b231-5d698438f2dc', 'eafd2146-1623-4dd7-aca4-539e777aa0b4', 'Manuais Escolares'),
       ('f48dae52-0133-4e62-9946-eb9c2d33bd71', 'eafd2146-1623-4dd7-aca4-539e777aa0b4', 'eBooks'),
       ('f6eda77d-eff8-4ca6-a98d-bc8e8a5ecbf2', 'eafd2146-1623-4dd7-aca4-539e777aa0b4', 'Livros'),
       ('2ced2e0e-72c2-45ca-b649-cb3c11889585', 'eafd2146-1623-4dd7-aca4-539e777aa0b4', 'Audio Livros');


create table authors
(
  id          char(36) unique primary key,
  name        varchar(192),
  fk_category char(36),
  created_at  timestamp default current_timestamp
) engine = InnoDB;

insert into authors(id, fk_category, name)
values ('2321fd00-c9d6-4dda-98d2-2d38910b0f0b', 'd32f9e34-ec51-4334-9461-294f42f1e122', 'William Shakespeare'),
       ('fef25a15-34ba-4dda-b63c-2db60eb3c2ee', 'd32f9e34-ec51-4334-9461-294f42f1e122', 'Agatha Christie'),
       ('45010d69-82d8-498f-b9c6-0c5f6106ad0a', '81962811-4bbe-4cb5-9a24-a5e40be43814', 'Barbara Cartland'),
       ('d1275f4c-5c10-42dd-99d4-f8d6dc41f3a6', '81962811-4bbe-4cb5-9a24-a5e40be43814', 'Danielle Steel'),
       ('dbc38343-8284-4d0c-a24e-9ad3b264e948', '945982c9-11b8-4a27-b04d-82e7baa20117', 'Harold Robbins'),
       ('c0a9324b-10e2-45f3-a175-a6b5f5bb0e93', '945982c9-11b8-4a27-b04d-82e7baa20117', 'Georges Simenon'),
       ('c7cdddb1-2a92-40d6-909f-6f56a914eeeb', 'c0e3599a-a8cf-4d67-85cc-bb2910f68c1c', 'Agatha Christie'),
       ('5a9d8186-be58-4d25-a211-95de1bc6bc2e', 'c0e3599a-a8cf-4d67-85cc-bb2910f68c1c', 'Danielle Steel'),
       ('59d82624-dfb4-4677-a01c-861e5f7c45f8', '45c59a7c-389e-4a62-ba76-612e8d352b56', 'Enid Blyton'),
       ('dc6e3b8f-630f-4462-81b8-0363f7e2e27a', '45c59a7c-389e-4a62-ba76-612e8d352b56', 'J. K. Rowling'),
       ('363f9a89-9f0a-43d3-9ed4-defbf9e8c402', 'e458c882-3584-4a24-998b-dc07e94d0dcb', 'Sidney Sheldon'),
       ('692d7c84-c748-4a07-8430-095cd01fbe39', 'e458c882-3584-4a24-998b-dc07e94d0dcb', 'Eiichiro Oda'),
       ('e87a1355-66d4-419a-9047-285c2d8d8849', '79bcf182-07db-43bc-b4bc-00616b2ceaa5', 'Gilbert Patten'),
       ('aa71ab10-b9c1-49e2-ae42-9a1711a8f004', '79bcf182-07db-43bc-b4bc-00616b2ceaa5', 'Barbara Cartland'),
       ('2eb5783c-14f6-4695-a9ce-9cf066eda423', '5e7d4291-1edf-4566-b450-81e34b5c4daf', 'William Shakespeare'),
       ('e9fb1e7a-f47c-4069-94cd-877599bbabef', '5e7d4291-1edf-4566-b450-81e34b5c4daf', 'Danielle Steel'),
       ('47774df8-586d-4aac-869d-567647bc1ad7', 'e8fdbec0-6c91-4500-a368-8a9bc9f55129', 'Tom Clancy'),
       ('5300b5ea-198c-4032-8e54-593b4898a0ec', 'e8fdbec0-6c91-4500-a368-8a9bc9f55129', 'Dr. Seuss'),
       ('6a9e19a8-d297-4763-989f-637039beeb77', 'febf2d9a-43a0-4c8a-bb2b-f90b953b23cf', 'Akira Toriyama'),
       ('06e20f51-2d90-4c6e-a5b2-ede0a2acfc51', 'febf2d9a-43a0-4c8a-bb2b-f90b953b23cf', 'Sidney Sheldon'),
       ('6c5cb564-0b89-47e4-bbe1-0780368b47be', '543b2013-4967-4ba5-b443-0ed8df6e86b1', 'J. K. Rowling'),
       ('80e64230-2a54-41f3-a7dc-ad84cd0338c0', '543b2013-4967-4ba5-b443-0ed8df6e86b1', 'Enid Blyton'),
       ('b645f65b-1019-4296-93ed-e9ebc75ae617', 'f12fc6d6-03ac-47dd-b231-5d698438f2dc', 'William Shakespeare'),
       ('27b231bf-889c-4c76-a0d7-7bea6bf17b4d', 'f48dae52-0133-4e62-9946-eb9c2d33bd71', 'Georges Simenon'),
       ('1f794baf-2785-4fc3-8bc8-8def7e81d5e5', 'f6eda77d-eff8-4ca6-a98d-bc8e8a5ecbf2', 'Harold Robbins'),
       ('a3a43af5-865c-40b2-871b-7d5872b72b79', '2ced2e0e-72c2-45ca-b649-cb3c11889585', 'Danielle Steel'),
       ('2042fba4-9009-4c72-ae35-089a840bd7ed', '2ced2e0e-72c2-45ca-b649-cb3c11889585', 'Barbara Cartland'),
       ('8f3f28af-6560-4556-bf61-7260616cef99', 'f6eda77d-eff8-4ca6-a98d-bc8e8a5ecbf2', 'Agatha Christie'),
       ('2ced2e0e-72c2-45ca-b649-cb3c11889585', 'f6eda77d-eff8-4ca6-a98d-bc8e8a5ecbf2', 'Leo Tolstoy');





















