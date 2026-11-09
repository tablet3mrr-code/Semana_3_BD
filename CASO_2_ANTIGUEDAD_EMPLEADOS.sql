SELECT
    UPPER(nombre_emp || ' ' || appaterno_emp)
        AS "Nombre Empleado",

    TO_CHAR(
        NVL(sueldo_emp, 0),
        'FML999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.''')
        AS "Sueldo con Formato",

    CASE
        WHEN sueldo_emp > 2000000 THEN 'ALTO'
        ELSE 'MEDIO'
    END AS "Clasificación Sueldo",

    TRUNC(
        MONTHS_BETWEEN(SYSDATE, fecing_emp) / 12
    ) AS "Años Antiguedad",

    'Corresponde bono ' ||
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecing_emp) / 12) > 20
            THEN '15%: '
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecing_emp) / 12) >= 11
            THEN '10%: '
        ELSE '5%: '
    END ||
    TO_CHAR(
        ROUND(
            NVL(sueldo_emp, 0) *
            CASE
                WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecing_emp) / 12) > 20
                    THEN 0.15
                WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecing_emp) / 12) >= 11
                    THEN 0.10
                ELSE 0.05
            END
        ),
        'FML999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.''')
        AS "BONO"

FROM EMPLEADO

WHERE id_categoria_emp = 3
  AND id_sucursal <> &CODIGO_SUCURSAL
  AND MONTHS_BETWEEN(SYSDATE, fecing_emp) > 60

ORDER BY sueldo_emp DESC;
