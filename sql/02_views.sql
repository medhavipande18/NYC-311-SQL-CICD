CREATE OR REPLACE VIEW vw_daily_request_volume AS
SELECT
  DATE_TRUNC('day', created_date) AS request_day,
  COUNT(*) AS request_count
FROM nyc_311_requests
WHERE created_date IS NOT NULL
GROUP BY request_day
ORDER BY request_day;

CREATE OR REPLACE VIEW vw_top_complaints AS
SELECT
  complaint_type,
  COUNT(*) AS request_count
FROM nyc_311_requests
WHERE complaint_type IS NOT NULL
GROUP BY 1
ORDER BY request_count DESC;

CREATE OR REPLACE VIEW vw_status_breakdown AS
SELECT
  status,
  COUNT(*) AS request_count
FROM nyc_311_requests
WHERE status IS NOT NULL
GROUP BY 1
ORDER BY request_count DESC;