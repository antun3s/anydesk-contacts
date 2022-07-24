#!/bin/bash

ANYDESKCONFIG=~/.anydesk/user.conf
HTMLFILE=~/Documents/anydesk-contacts.html

ANYDESKCONTACTS=/tmp/anydeskconatcts.txt

function get_anydesk_contacts {
    grep 'ad.roster.items=' $ANYDESKCONFIG `# find saved contatcs on config file ` |\
        sed 's/ad.roster.items\=//g' `# ignore line's title ` |\
        sed 's/\;/;\n/g' `# use sed to change ; to new line, so each line contain a contact` |\
        grep -e '.*,.*,[a-zA-Z]' `# filter for keep named contacts ` |\
        sort -t\, -k3 `# sort contacts by their name ` |\
        awk -F\,  '{print "<tr> <td>  <a href=\"anydesk:"$2"\"> "$3" </a>        </td> <td>    <a href=\"anydesk:"$2"\"> "$2" </a>       </td> </tr>  "}' `# format lines to insert in HTML` \
        > $ANYDESKCONTACTS
}

function clen_old_data {
    # clean temporary and old files
    echo '' >  $HTMLFILE
    echo '' >  $ANYDESKCONTACTS
}

function gen_page {
    echo -e $HTMLFILESTART >> $HTMLFILE
    cat $ANYDESKCONTACTS >> $HTMLFILE
    echo -e $HTMLFILEEND >> $HTMLFILE
}

read -r -d '' HTMLFILESTART  <<- EOV
	<!DOCTYPE html>
	<html>
	<head>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<style>
	* {
	  box-sizing: border-box;
	}
	
	#myInput {
	  background-position: 10px 10px;
	  background-repeat: no-repeat;
	  width: 40%;
	  font-size: 16px;
	  padding: 12px 20px 12px 40px;
	  border: 1px solid #ddd;
	  margin-bottom: 12px;
	}
	
	#myTable {
	  border-collapse: collapse;
	  width: 100%;
	  border: 1px solid #ddd;
	  font-size: 18px;
	}
	
	#myTable th, #myTable td {
	  text-align: left;
	  padding: 12px;
	}
	
	#myTable tr {
	  border-bottom: 1px solid #ddd;
	}
	
	#myTable tr.header, #myTable tr:hover {
	  background-color: #f1f1f1;
	}
	    
    a, a:hover, a:focus, a:active { text-decoration: none; color: inherit; }

    td a {
        width: 100%;
        display: block;
    }      

    td {
        /* Cell styles for demonstration purposes only */
        border: 1px solid black;
        width: 10em;
    }

	body {
	    font-family: 'Roboto', sans-serif;
    }	
     </style>
	</head>
	<body>

    <div>
    <span style="float:right"><a href="https://github.com/antun3s/anydesk-contacts" style="text-decoration:none;">GitHub Repository</a></span><h1>My AnyDesk Contacts</h1>
	<input type="text" id="myInput" onkeyup="myFunction()" placeholder="🔎 Search for Contacts.." title="Type in contact name " autofocus="true" >
    </div>

    <table id="myTable">
	  <tr class="header">
	    <th style="width:60%;">Name</th>
	    <th style="width:40%;">ID</th>
	  </tr>
EOV

read -r -d '' HTMLFILEEND  <<- EOV
	</table>
	
	<script>
	function myFunction() {
	  var input, filter, table, tr, td, i, txtValue;
	  input = document.getElementById("myInput");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("myTable");
	  tr = table.getElementsByTagName("tr");
	  for (i = 0; i < tr.length; i++) {
	    td = tr[i].getElementsByTagName("td")[0];
	    if (td) {
	      txtValue = td.textContent || td.innerText;
	      if (txtValue.toUpperCase().indexOf(filter) > -1) {
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";
	      }
	    }       
	  }
	}
	</script>
	
	</body>
	</html>
EOV

# Let's start! 
clen_old_data
get_anydesk_contacts # 
gen_page
