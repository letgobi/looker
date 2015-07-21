- connection: appsflyer

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: events

- explore: installations

- view: add_name
  derived_table:
    sql: |
      SELECT
      
        installations.install_date,
        installations.install_week,
        installations.partner,
        installations.os,
        installations.campaign_country,
        installations.campaign_gender,
        installations,
        GNL_24,
        GNL
        
      FROM
      
          (SELECT 
            DATE(install_time) as install_date,
            YEARWEEK(install_time) as install_week,
            pid as partner,
            project as os,
            CASE  
                WHEN campaign LIKE '% - US - %' OR campaign LIKE '%United States%' THEN 'United States'
                WHEN campaign LIKE '% - AU - %' OR campaign LIKE '%Australia%' THEN 'Australia'
                WHEN campaign LIKE '% - CA - %' OR campaign LIKE '%Canada%' THEN 'Canada'
                WHEN campaign LIKE '% - NZ - %' OR campaign LIKE '%New Zealand%' THEN 'New Zealand'
                WHEN campaign LIKE '% - IE - %' OR campaign LIKE '%Ireland%' THEN 'Ireland'
                WHEN campaign LIKE '% - SG - %' OR campaign LIKE '%Singapore%' THEN 'Singapore'
                WHEN campaign LIKE '% - HK - %' OR campaign LIKE '%Hong Kong%' THEN 'Hong Kong'
                WHEN campaign LIKE '% - ES - %' OR campaign LIKE '%Spain%' THEN 'Spain'
                WHEN campaign LIKE '% - IT - %' OR campaign LIKE '%Italy%' THEN 'Italy'
                WHEN campaign LIKE '% - TR - %' OR campaign LIKE '%Turkey%' THEN 'Turkey'
                WHEN campaign LIKE '% - NO - %' OR campaign LIKE '%Norway%' THEN 'Norway'
                WHEN campaign LIKE '% - SE - %' OR campaign LIKE '%Sweden%' THEN 'Sweden'
                WHEN campaign LIKE '% - FI - %' OR campaign LIKE '%Finland%' THEN 'Finland'
                WHEN campaign LIKE '% - NL - %' OR campaign LIKE '%Netherlands%' THEN 'Netherlands'
                WHEN campaign LIKE '% - KR - %' OR campaign LIKE '%South Korea%' THEN 'South Korea'
                ELSE 'United States'
            END as campaign_country,
            CASE  
                WHEN campaign LIKE '% Male %' THEN 'Male'
                WHEN campaign LIKE '% Female %' THEN 'Female'
                ELSE 'All'
            END as campaign_gender,
            COUNT(*) as installations
          FROM 
            installations 
          GROUP BY 1, 2, 3, 4, 5, 6) installations
          
          JOIN
          
          (SELECT
          
            install_date,
            install_week,
            partner,
            os,
            campaign_country,
            campaign_gender,
            SUM(GNL_24) as GNL_24,
            SUM(GNL) as GNL
            
          FROM
          
              (SELECT 
                DATE(install_time) as install_date,
                YEARWEEK(install_time) as install_week,
                pid as partner,
                project as os,
                CASE  
                  WHEN campaign LIKE '% - US - %' OR campaign LIKE '%United States%' THEN 'United States'
                  WHEN campaign LIKE '% - AU - %' OR campaign LIKE '%Australia%' THEN 'Australia'
                  WHEN campaign LIKE '% - CA - %' OR campaign LIKE '%Canada%' THEN 'Canada'
                  WHEN campaign LIKE '% - NZ - %' OR campaign LIKE '%New Zealand%' THEN 'New Zealand'
                  WHEN campaign LIKE '% - IE - %' OR campaign LIKE '%Ireland%' THEN 'Ireland'
                  WHEN campaign LIKE '% - SG - %' OR campaign LIKE '%Singapore%' THEN 'Singapore'
                  WHEN campaign LIKE '% - HK - %' OR campaign LIKE '%Hong Kong%' THEN 'Hong Kong'
                  WHEN campaign LIKE '% - ES - %' OR campaign LIKE '%Spain%' THEN 'Spain'
                  WHEN campaign LIKE '% - IT - %' OR campaign LIKE '%Italy%' THEN 'Italy'
                  WHEN campaign LIKE '% - TR - %' OR campaign LIKE '%Turkey%' THEN 'Turkey'
                  WHEN campaign LIKE '% - NO - %' OR campaign LIKE '%Norway%' THEN 'Norway'
                  WHEN campaign LIKE '% - SE - %' OR campaign LIKE '%Sweden%' THEN 'Sweden'
                  WHEN campaign LIKE '% - FI - %' OR campaign LIKE '%Finland%' THEN 'Finland'
                  WHEN campaign LIKE '% - NL - %' OR campaign LIKE '%Netherlands%' THEN 'Netherlands'
                  WHEN campaign LIKE '% - KR - %' OR campaign LIKE '%South Korea%' THEN 'South Korea'
                  ELSE 'United States'
                END as campaign_country,
                CASE  
                    WHEN campaign LIKE '% Male %' THEN 'Male'
                    WHEN campaign LIKE '% Female %' THEN 'Female'
                    ELSE 'All'
                END as campaign_gender,
                CASE WHEN TIMESTAMPDIFF(HOUR, install_time, event_time)<=24 THEN 1 ELSE 0 END as GNL_24,
                1 as GNL
              FROM 
                events 
              WHERE
                event_name='product-sell-complete') gnl_events
                
          GROUP BY 1, 2, 3, 4, 5, 6) GNL
      
      ON 
      
        installations.install_date=GNL.install_date AND
        installations.partner=GNL.partner AND
        installations.os=GNL.os AND
        installations.campaign_country=GNL.campaign_country AND
        installations.campaign_gender=GNL.campaign_gender

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: install_date
    sql: ${TABLE}.install_date

  - dimension: install_week
    type: number
    sql: ${TABLE}.install_week

  - dimension: partner
    sql: ${TABLE}.partner

  - dimension: os
    sql: ${TABLE}.os

  - dimension: campaign_country
    sql: ${TABLE}.campaign_country

  - dimension: campaign_gender
    sql: ${TABLE}.campaign_gender

  - dimension: installations
    type: number
    sql: ${TABLE}.installations

  - dimension: gnl_24
    type: number
    sql: ${TABLE}.GNL_24

  - dimension: gnl
    type: number
    sql: ${TABLE}.GNL

  sets:
    detail:
      - install_date
      - install_week
      - partner
      - os
      - campaign_country
      - campaign_gender
      - installations
      - gnl_24
      - gnl


