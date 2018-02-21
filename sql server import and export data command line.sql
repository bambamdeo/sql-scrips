--The following example exports data using Username and Password where user and password is Db credential.
--The example exports table bcptest from database testdb from  server dbserver and stores the data in file c:\last\data1.dat:

bcp bcptest out "c:\last\data1.dat" -c -t -S dbserver -d testdb -G -U username -P xxxxx

--The following example imports data using Username and Password where user and password is a db credential. 
--The example imports data from file c:\last\data1.dat into table bcptest for database testdb on server dbserver using  Username/Password:

bcp bcptest in "c:\last\data1.dat" -c -t -S dbserver -d testdb -G -U username -P xxxxx


