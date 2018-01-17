SELECT a.tablespace_name                           Tablespace, 
       ROUND(( 1 - ( fbytes / tbytes ) ) * 100, 1) Percent_Used, 
       ROUND(tbytes / 1024 / 1024 / 1024, 1)       GB_Total, 
       ROUND(fbytes / 1024 / 1024 / 1024, 1)              GB_Free, 
       ROUND(( tbytes - fbytes ) / 1024 / 1024 / 1024, 1) GB_Used ,
       ROUND(mbytes / 1024 / 1024 / 1024, 1 ) Max_Size,
       ROUND((( tbytes - fbytes ) / 1024 / 1024 / 1024) / ((mbytes / 1024 / 1024 / 1024) + .01), 3) * 100 Per_Max
FROM   (SELECT tablespace_name, 
               SUM(bytes) tbytes,
               SUM(maxbytes) mbytes
        FROM   dba_data_files 
        GROUP  BY tablespace_name 
        UNION ALL 
        SELECT tablespace_name, 
               SUM(bytes) tbytes ,
               SUM(maxbytes) mbytes
        FROM   dba_temp_files 
        GROUP  BY tablespace_name) a 
       left outer join (SELECT tablespace_name, 
                               SUM(bytes) fbytes 
                        FROM   dba_free_space 
                        GROUP  BY tablespace_name 
                        UNION ALL 
                        SELECT tablespace_name, 
                               SUM(user_bytes) fbytes 
                        FROM   dba_temp_files 
                        GROUP  BY tablespace_name) b 
                    ON a.tablespace_name = b.tablespace_name
                    Order by 7 desc;
