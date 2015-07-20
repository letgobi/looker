- view: installations
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: advertising_id
    sql: ${TABLE}.advertising_id

  - dimension: android_id
    sql: ${TABLE}.android_id

  - dimension: app_version
    sql: ${TABLE}.app_version

  - dimension: campaign
    sql: ${TABLE}.campaign

  - dimension: carrier
    sql: ${TABLE}.carrier

  - dimension: city
    sql: ${TABLE}.city

  - dimension_group: click
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.click_time

  - dimension: click_url
    sql: ${TABLE}.click_url

  - dimension: contributor1
    sql: ${TABLE}.contributor1

  - dimension: contributor2
    sql: ${TABLE}.contributor2

  - dimension: contributor3
    sql: ${TABLE}.contributor3

  - dimension: country_code
    sql: ${TABLE}.country_code

  - dimension: cpi
    sql: ${TABLE}.cpi

  - dimension: customer_user_id
    sql: ${TABLE}.customer_user_id

  - dimension: device_id
    sql: ${TABLE}.device_id

  - dimension: device_type
    sql: ${TABLE}.device_type

  - dimension: imei
    sql: ${TABLE}.imei

  - dimension_group: install
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.install_time

  - dimension: ip
    sql: ${TABLE}.ip

  - dimension: language
    sql: ${TABLE}.language

  - dimension: mac
    sql: ${TABLE}.mac

  - dimension: operator
    sql: ${TABLE}.operator

  - dimension: os_version
    sql: ${TABLE}.os_version

  - dimension: pid
    sql: ${TABLE}.pid

  - dimension: project
    sql: ${TABLE}.project

  - dimension: prt
    sql: ${TABLE}.prt

  - dimension: sdk_version
    sql: ${TABLE}.sdk_version

  - dimension: site_id
    sql: ${TABLE}.site_id

  - dimension: sub1
    sql: ${TABLE}.sub1

  - dimension: sub2
    sql: ${TABLE}.sub2

  - dimension: sub3
    sql: ${TABLE}.sub3

  - dimension: sub4
    sql: ${TABLE}.sub4

  - dimension: sub5
    sql: ${TABLE}.sub5

  - dimension: wifi
    sql: ${TABLE}.wifi

  - measure: count
    type: count
    drill_fields: [id]

