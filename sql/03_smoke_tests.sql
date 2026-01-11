DO $$
BEGIN
  IF (SELECT COUNT(*) FROM nyc_311_requests) = 0 THEN
    RAISE EXCEPTION 'Smoke test failed: nyc_311_requests is empty';
  END IF;
END $$;

DO $$
BEGIN
  IF (SELECT COUNT(*) FROM vw_daily_request_volume) = 0 THEN
    RAISE EXCEPTION 'Smoke test failed: vw_daily_request_volume is empty';
  END IF;
END $$;

DO $$
BEGIN
  IF (SELECT COUNT(*) FROM vw_top_complaints) = 0 THEN
    RAISE EXCEPTION 'Smoke test failed: vw_top_complaints is empty';
  END IF;
END $$;