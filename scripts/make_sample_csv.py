import csv
from pathlib import Path

RAW_INPUT = Path("data/raw/311_Service_Requests_from_2010_to_Present.csv")
OUT_SAMPLE = Path("data/sample/nyc_311_sample.csv")
N_ROWS = 20000  # data rows (excluding header)

# Columns in your raw file (as seen in your header)
REQUIRED_COLS = [
    "Unique Key",
    "Created Date",
    "Closed Date",
    "Agency",
    "Complaint Type",
    "Descriptor",
    "Borough",
    "Status",
    "Incident Zip",
    "Latitude",
    "Longitude",
]

# Output column names (what our SQL expects)
RENAME = {
    "Unique Key": "unique_key",
    "Created Date": "created_date",
    "Closed Date": "closed_date",
    "Agency": "agency",
    "Complaint Type": "complaint_type",
    "Descriptor": "descriptor",
    "Borough": "borough",
    "Status": "status",
    "Incident Zip": "incident_zip",
    "Latitude": "latitude",
    "Longitude": "longitude",
}

def detect_delimiter(sample_line: str) -> str:
    # Your file appears tab-separated
    if "\t" in sample_line and "," not in sample_line:
        return "\t"
    if "," in sample_line and "\t" not in sample_line:
        return ","
    # If ambiguous, prefer tab (common for NYC 311 exports)
    return "\t"

def main():
    if not RAW_INPUT.exists():
        raise FileNotFoundError(f"Raw input not found: {RAW_INPUT}")

    OUT_SAMPLE.parent.mkdir(parents=True, exist_ok=True)

    with RAW_INPUT.open("r", encoding="utf-8", errors="replace", newline="") as fin:
        first_line = fin.readline()
        delim = detect_delimiter(first_line)

        # Rewind and use DictReader with detected delimiter
        fin.seek(0)
        reader = csv.DictReader(fin, delimiter=delim)

        # Validate columns exist
        missing = [c for c in REQUIRED_COLS if c not in reader.fieldnames]
        if missing:
            raise ValueError(f"Missing required columns in raw file: {missing}")

        with OUT_SAMPLE.open("w", encoding="utf-8", newline="") as fout:
            writer = csv.DictWriter(
                fout,
                fieldnames=[RENAME[c] for c in REQUIRED_COLS],
                delimiter=",",
                quotechar='"',
                quoting=csv.QUOTE_MINIMAL,
            )
            writer.writeheader()

            count = 0
            for row in reader:
                out_row = {RENAME[k]: row.get(k, "") for k in REQUIRED_COLS}
                writer.writerow(out_row)
                count += 1
                if count >= N_ROWS:
                    break

    print(f"Wrote sample CSV: {OUT_SAMPLE} with {count} rows (delimiter detected: {repr(delim)})")

if __name__ == "__main__":
    main()