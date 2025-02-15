<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Donation Data</title>
<style>
    body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
    color: #333;
    opacity: 0; /* Initially hidden */
    animation: fadeIn 1.5s forwards ease-in-out; /* Faster fade-in animation */
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

table {
    width: 100%;
    max-width: 100%;
    border-collapse: collapse;
    margin: 30px 0;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Softer shadow */
    overflow: hidden;
}

th, td {
    padding: 14px;
    text-align: left;
    border-bottom: 1px solid #e0e0e0; /* Light grey border for separation */
    font-size: 14px;
}

th {
    background-color: #F0E1F0; /* Slightly darker beige */
    color: #333; 
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

td {
    background-color: #fff;
}

#downloadPDF, #sortBtn {
    background-color: #F0E1F0;
    color: #333;
    padding: 10px 30px;
    border: 2px solid #333;
    font-size: 15px;
    font-weight: bold;
    margin-top: 20px;
    cursor: pointer;
    border-radius: 5px; /* Rounded corners */
    transition: background-color 0.3s ease, transform 0.2s ease;
}

#downloadPDF:hover, #sortBtn:hover {
    background-color: #F0E1F0;
    color: #fff;
    transform: translateY(-2px); /* Lift effect on hover */
}

#downloadPDF:active, #sortBtn:active {
    transform: scale(0.95); /* Shrink on click */
}

.h1 {
    text-align: center;
    color: #333;
    margin-bottom: 40px;
    font-size: 2em; /* Larger font size for title */
    animation: slideIn 1s ease-out;
}
#downloadPDF {
    background-color: #F0E1F0;
    color: #333;
    padding: 10px 30px;
    border: 2px solid #333;
    font-size: 15px;
    font-weight: bold;
    margin-top: 20px;
    cursor: pointer;
    border-radius: 5px; /* Rounded corners */
    transition: background-color 0.3s ease, transform 0.2s ease;
    float: right; /* Align to the right */
}

@keyframes slideIn {
    from {
        transform: translateY(-30px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

select {
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 5px;
    border: 1px solid #ddd;
    outline: none;
    transition: border 0.3s ease;
    margin-right: 10px;
}

select:focus {
    border-color: #333;
}

@media print {
    table {
        page-break-inside: auto;
    }
    tr {
        page-break-inside: avoid;
        page-break-after: auto;
    }
}

</style>
</head>
<body>
<div class="data">
<select id="sortOption">
    <option value="">Select Sorting Option</option>
    <option value="date">Date-wise Sorting</option>
    <option value="alphabetical">Alphabetical Sorting</option>
</select>
<button id="sortBtn">Sort Table</button>
<button id="downloadPDF">Download PDF</button>

<h1 class="h1">DONATION DATA</h1>

<%

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con;
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bloomers","root","");
	PreparedStatement ps=con.prepareStatement("select name,email,amount,message, response_time from donations");
	ResultSet rs=ps.executeQuery();
	
	out.println("<table id='responseTable'>");
    out.println("<thead><tr>");
    out.println("<th>Name</th>");
    out.println("<th>Email</th>");
    out.println("<th>Amount</th>");
    out.println("<th>Message</th>");
    out.println("<th>Response Time</th>");  
    out.println("</tr></thead>");
    out.println("<tbody>");
	
	while(rs.next())
	{
		 out.println("<tr>");
		 out.println("<td>" + rs.getString("name") + "</td>");
         out.println("<td>" + rs.getString("email") + "</td>");
         out.println("<td>" + rs.getString("amount") + "</td>");
         out.println("<td>" + rs.getString("message") + "</td>");
         out.println("<td>" + rs.getTimestamp("response_time") + "</td>");  
	   	 out.println("</tr>");
	}
    out.println("</tbody>");
	out.println("</table>");
%>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>

<script>

function sortTable(table, column, isDate) {
    const rows = Array.from(table.querySelectorAll('tbody tr'));
    rows.sort((rowA, rowB) => {
        let cellA = rowA.cells[column].innerText.trim();
        let cellB = rowB.cells[column].innerText.trim();

        if (isDate) {
            return new Date(cellA) - new Date(cellB);
        } else {
            return cellA.localeCompare(cellB);
        }
    });

    rows.forEach(row => table.querySelector('tbody').appendChild(row));
}


let sortBtn = document.getElementById('sortBtn');
let sortOption = document.getElementById('sortOption');
sortBtn.addEventListener('click', () => {
    const table = document.getElementById('responseTable');

    if (sortOption.value === 'date') {
        sortTable(table, 4, true);  
    } else if (sortOption.value === 'alphabetical') {
        sortTable(table, 0, false); 
    } else {
        alert("Please select a valid sorting option.");
    }
});


let btn = document.getElementById('downloadPDF');
btn.addEventListener('click', () => {
    btn.style.display = 'none';  
    sortBtn.style.display = 'none';  
    sortOption.style.display = 'none'; 
    const pdfContent = document.querySelector('.data');  
    const opt = {
        margin: [0.5, 0.5, 0.5, 0.5],  
        filename: 'REGISTER_DATA.pdf', 
        image: { type: 'jpeg', quality: 0.98 }, 
        html2canvas: { scale: 2, logging: true, dpi: 192, letterRendering: true }, 
        jsPDF: { unit: 'in', format: 'a4', orientation: 'landscape' }  
    };

    html2pdf().from(pdfContent).set(opt).save().then(() => {
        btn.style.display = 'block';  
        sortBtn.style.display = 'block'; 
        sortOption.style.display = 'block'; 
    });
});
</script>

</body>
</html>
