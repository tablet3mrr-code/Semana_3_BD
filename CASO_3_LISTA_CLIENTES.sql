SELECT
    CASE
        WHEN renta_cli >= 1000000 THEN 'PREMIUM'
        WHEN renta_cli >= 600000 THEN 'ALTA'
        WHEN renta_cli >= 300000 THEN 'MEDIA'
        ELSE 'BAJA'
    END AS CLASIFICACION_RENTA,

    COUNT(*) AS CANTIDAD_CLIENTES,

    TO_CHAR(
        ROUND(AVG(renta_cli)),
        'FML999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.''')
        AS RENTA_PROMEDIO,

    CASE
        WHEN COUNT(
            CASE
                WHEN fonofijo_cli IS NOT NULL
                  OR celular_cli IS NOT NULL
                THEN 1
            END
        ) = 0
            THEN 'Clientes Sin Teléfono'
        ELSE 'Clientes con Teléfono'
    END AS ESTADO_TELEFONO

FROM CLIENTE

GROUP BY
    CASE
        WHEN renta_cli >= 1000000 THEN 'PREMIUM'
        WHEN renta_cli >= 600000 THEN 'ALTA'
        WHEN renta_cli >= 300000 THEN 'MEDIA'
        ELSE 'BAJA'
    END

HAVING AVG(renta_cli) > 200000

ORDER BY
    CASE
        WHEN AVG(renta_cli) >= 1000000 THEN 4
        WHEN AVG(renta_cli) >= 600000 THEN 1
        WHEN AVG(renta_cli) >= 300000 THEN 2
        ELSE 3
    END;
