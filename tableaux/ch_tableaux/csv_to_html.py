import csv
import html

def csv_to_html():
    html_start = """<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>CH Table</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
            font-size: 14px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        th {
            background-color: #f2f2f2;
            position: sticky;
            top: 0;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        td:hover {
            white-space: normal;
            word-break: break-all;
        }
    </style>
</head>
<body>
<h1>Résultats du traitement des dumps pour le mot logique en chinois</h1>
    <table>"""

    with open('output.csv', 'r', encoding='utf-8') as f:
        reader = csv.reader(f, delimiter='\t')
        headers = next(reader)
        
        # Create table headers
        html_content = "<thead><tr>"
        for header in headers:
            html_content += f"<th>{html.escape(header)}</th>"
        html_content += "</tr></thead><tbody>"
        
        # Create table rows
        for row in reader:
            html_content += "<tr>"
            for cell in row:
                html_content += f"<td>{html.escape(str(cell))}</td>"
            html_content += "</tr>"

    html_end = "</tbody></table></body></html>"
    
    with open('ch_table.html', 'w', encoding='utf-8') as f:
        f.write(html_start + html_content + html_end)

if __name__ == "__main__":
    csv_to_html()