function validateAndUpload() {
    const fileInput = document.getElementById("excelFile");
    const file = fileInput.files[0];

    if (!file || !file.name.endsWith(".xlsx")) {
        alert("Please upload a valid .xlsx file.");
        return;
    }

    const formData = new FormData();
    formData.append("file", file);

    fetch("/upload", {
        method: "POST",
        body: formData
    })
        .then(res => res.text())
        .then(msg => {
            document.getElementById("response").innerText = msg;
        })
        .catch(err => {
            console.error(err);
            alert("Upload failed.");
        });
}

function searchAccount() {
    const acc = document.getElementById("searchAccount").value.trim();
    if (!acc.match(/^\d{14}$/)) {
        alert("Enter valid 14-digit account number.");
        return;
    }

    const formData = new URLSearchParams();
    formData.append("accountNumber", acc);

    fetch("/search", {
        method: "POST",
        body: formData,
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        }
    })
        .then(res => res.json())
        .then(data => {
            const tbody = document.getElementById("resultBody");
            tbody.innerHTML = "";

            if (data && data.accountNumber) {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${data.accountNumber}</td>
                    <td>${data.createdByUpdatedByIsActive}</td>
                    <td>
                        <input type="text" value="${data.transferNumber}" id="editTransfer" />
                    </td>
                    <td>
                        <button onclick="updateTransfer('${data.accountNumber}')">Save</button>
                    </td>
                `;
                tbody.appendChild(row);
            } else {
                tbody.innerHTML = "<tr><td colspan='4'>Account not found.</td></tr>";
            }
        });
}

function updateTransfer(accountNumber) {
    const newTransfer = document.getElementById("editTransfer").value.trim();
    const formData = new URLSearchParams();
    formData.append("accountNumber", accountNumber);
    formData.append("transferNumber", newTransfer);

    fetch("/update-transfer", {
        method: "POST",
        body: formData,
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        }
    })
        .then(res => res.text())
        .then(msg => {
            alert(msg);
        });
}
function clearUpload() {
    const fileInput = document.getElementById("excelFile");
    fileInput.value = ""; // Reset the file input
    document.getElementById("response").innerText = ""; // Clear the response message
}
