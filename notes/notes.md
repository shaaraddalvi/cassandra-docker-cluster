### Connecting to sqlsh

* `docker exec -it node0 /bin/bash`
* Once inside a container, `cqlsh`

### Creating a keyspace
```
CREATE KEYSPACE test_ks WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 2};
```

### Look at the keyspace
```
shaarad@MacBookPro ~ % docker exec node0 nodetool status test_ks
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load        Tokens  Owns (effective)  Host ID                               Rack
UN  172.18.0.6  85.51 KiB   16      76.0%             23966d83-4c46-46f6-b4a1-38a9d8f53de3  rack1
UN  172.18.0.2  104.34 KiB  16      64.7%             ee60e784-46b3-42ca-b890-757b0ea63ed3  rack1
UN  172.18.0.5  80.54 KiB   16      59.3%             7db96b60-9733-46e6-8c9f-87d935163ec6  rack1
```

* As the `replication_factor` is `2`, the sum of effective ownership is `(76.0 + 64.7 + 59.3)` = `200%`.

### Looking at the ring for the keyspace
```
shaarad@MacBookPro ~ % docker exec node0 nodetool ring test_ks

Datacenter: datacenter1
==========
Address          Rack        Status State   Load            Owns                Token
                                                                                8929374636794624570
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              -9091082935633797655
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              -8660071454703129571
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              -8393354021207369034
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              -7993140705782188735
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              -7740881109059119771
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              -7297312120972430745
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              -6935584021092140176
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              -6683504592130161554
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              -6206015010280218485
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              -5693145706412008024
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              -5361638362789056728
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              -4866299249673894753
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              -4561809692127926444
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              -4201790547496636678
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              -3921370132886473488
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              -3539659041194395442
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              -3303389100984273410
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              -2849869516546440676
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              -2477306641524043903
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              -2239048111211210014
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              -1832018111804013660
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              -1339180102134148911
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              -1014346179191662866
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              -419043810231263616
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              61409702033916672
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              492735626820933770
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              797325394744810313
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              1207031091218594763
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              1458020519281722412
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              1876698202192411971
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              2324269542090292357
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              2626975442460736791
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              3120218207873003943
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              3676099242789927879
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              4087582450951539442
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              4612012415581443299
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              5027650075153083179
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              5395993266779858497
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              5677587003465438080
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              6239330421825064324
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              6636653274173777115
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              7028474230784122548
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              7296610299162481377
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              7661458054257256671
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              7895073990119220203
172.18.0.2       rack1       Up     Normal  99.19 KiB       64.66%              8274755751678595453
172.18.0.6       rack1       Up     Normal  80.35 KiB       75.99%              8639348910650745335
172.18.0.5       rack1       Up     Normal  75.39 KiB       59.34%              8929374636794624570
```