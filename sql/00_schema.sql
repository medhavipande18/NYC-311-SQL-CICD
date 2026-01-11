DROP TABLE IF EXISTS nyc_311_requests;

CREATE TABLE nyc_311_requests (
  unique_key BIGINT PRIMARY KEY,
  created_date TIMESTAMP NULL,
  closed_date TIMESTAMP NULL,
  agency TEXT NULL,
  complaint_type TEXT NULL,
  descriptor TEXT NULL,
  borough TEXT NULL,
  status TEXT NULL,
  incident_zip TEXT NULL,
  latitude DOUBLE PRECISION NULL,
  longitude DOUBLE PRECISION NULL
);

CREATE INDEX IF NOT EXISTS idx_created_date ON nyc_311_requests(created_date);
CREATE INDEX IF NOT EXISTS idx_complaint_type ON nyc_311_requests(complaint_type);
CREATE INDEX IF NOT EXISTS idx_borough ON nyc_311_requests(borough);
CREATE INDEX IF NOT EXISTS idx_status ON nyc_311_requests(status);