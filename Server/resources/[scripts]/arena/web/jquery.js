window.addEventListener("message", function (event) {
	switch (event["data"]["Action"]) {
		case "Show":
			$("#Arena").css("display", "block");
			break;

		case "Hide":
			$("#Arena").css("display", "none");
			break;

		case "Players":
			$("#Arena").html(`<b>MORTES CONSECUTIVAS: ${event["data"]["Streek"]}</b><br><b>JOGADORES PARTICIPANTES: ${event["data"]["Players"]}</b>`);
			break;
	}
});