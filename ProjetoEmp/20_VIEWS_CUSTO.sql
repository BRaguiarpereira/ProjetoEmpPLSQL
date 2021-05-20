
--MATERIAL,FICHA_TECNICA
CREATE OR REPLACE VIEW V_CUSTO_PRODUTO_DET
AS
SELECT A.COD_EMPRESA,
       A.COD_MAT,
       A.DESCRICAO,
       B.COD_MAT_NECES,
       C.DESCRICAO AS DESCRICAO_MAT_NEC,
       B.QTD_NECES,
       C.PRECO_UNIT,
       B.QTD_NECES*C.PRECO_UNIT CUSTO_NEC
 FROM MATERIAL A
 INNER JOIN FICHA_TECNICA B
 ON A.COD_MAT=B.COD_MAT_PROD
 AND A.COD_EMPRESA=B.COD_EMPRESA
 
 INNER JOIN MATERIAL C
 ON B.COD_MAT_NECES=C.COD_MAT
 AND A.COD_EMPRESA=C.COD_EMPRESA
 WHERE A.COD_TIP_MAT=2; --TIPO 2 MATERIAL PRODUZIDO
--AND A.COD_EMPRESA=1


-- TESTE VIEW
    SELECT * FROM V_CUSTO_PRODUTO_DET
    WHERE COD_EMPRESA=1
    AND COD_MAT=1;

--CRIICAO VIEW RESUMO DE CUSTO
    CREATE OR REPLACE VIEW V_CUSTO_PRODUTO_RESUMO
    AS
 SELECT A.COD_EMPRESA,
        A.COD_MAT,
        A.DESCRICAO,
        SUM(B.QTD_NECES*C.PRECO_UNIT) CUSTO,
        A.PRECO_UNIT PRECO_VENDA
        FROM MATERIAL A
        INNER JOIN FICHA_TECNICA B
        ON A.COD_MAT=B.COD_MAT_PROD
        AND A.COD_EMPRESA=B.COD_EMPRESA
         
        INNER JOIN MATERIAL C
        ON B.COD_MAT_NECES=C.COD_MAT
        AND A.COD_EMPRESA=C.COD_EMPRESA
         
        WHERE A.COD_TIP_MAT=2 --TIPO 2 MATERIAL PRODUZIDO
        GROUP BY A.COD_EMPRESA,A.COD_MAT,A.DESCRICAO,A.PRECO_UNIT;
        
    --TESTE VIEW
    
    SELECT * FROM V_CUSTO_PRODUTO_RESUMO
    WHERE COD_EMPRESA=1
    --AND COD_MAT=1;


