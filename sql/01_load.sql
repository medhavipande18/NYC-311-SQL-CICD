COPY nyc_311_requests (
  unique_key,
  created_date,
  closed_date,
  agency,
  complaint_type,
  descriptor,
  borough,
  status,
  incident_zip,
  latitude,
  longitude
)
FROM '/tmp/nyc_311_sample.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ',',
  QUOTE '"'
);