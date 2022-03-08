--**************************************************************************************************************
-- Consulta SQL donde pueda obtener los productos vendidos digitando tipo de documento y número de documento. **
--**************************************************************************************************************

SELECT cus_name, cus_last_name, cus_type_id, cus_document, pro_name
FROM customer cus
INNER JOIN invoice inv
    ON cus.cus_id = inv.customer_id
INNER JOIN invoice_has_product ihp
    ON inv.inv_id = ihp.invoice_id
INNER JOIN product pro
    ON ihp.product_id = pro.pro_id
WHERE cus_type_id = 'CC' AND cus_document = '126407868928' AND inv_status != 0;

--*************************************************************************************************************
-- Consultar productos por medio del nombre, el cual debe mostrar quien o quienes han sido sus proveedores. **
--*************************************************************************************************************

SELECT pro_name as nombre_producto, sup_id as id_supplier, sup_name as name_supplier
FROM supplier sup
INNER JOIN product pro
    ON sup.sup_id = pro.supplier_id
WHERE pro_name = 'Sambuca Cream';
