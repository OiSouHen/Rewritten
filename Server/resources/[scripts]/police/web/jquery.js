var selectPage = "Prender";
var reversePage = "Prender";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function () {
	functionPrender();

	window.addEventListener("message", function (event) {
		switch (event["data"]["action"]) {
			case "openSystem":
				$("#mainPage").css("display", "block");
				break;

			case "closeSystem":
				$("#mainPage").css("display", "none");
				break;

			case "reloadPrison":
				functionPrender();
				break;

			case "reloadFine":
				functionMultar();
				break;

			case "reloadAnnounce":
				functionAnunciar();
				break;

			case "reloadSearch":
				functionSearch(event["data"]["data"]);
				break;
		};
	});

	document.onkeyup = function (data) {
		if (data["which"] == 27) {
			$.post("http://police/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).on("click", "#mainMenu li", function () {
	if (selectPage != reversePage) {
		let isActive = $(this).hasClass('active');
		$('#mainMenu li').removeClass('active');
		if (!isActive) {
			$(this).addClass('active');
			reversePage = selectPage;

			$("#content").css("height", "414px");
			$("#content").css("margin", "76px 30px 30px 30px");
		};
	};
});
/* ----------FUNCTIONSEARCH---------- */
const functionSearch = (passaporte) => {
	if (passaporte != "") {
		$.post("http://police/SearchUser", JSON.stringify({ passaporte: parseInt(passaporte) }), (data) => {
			if (data["result"][0] == true) {
				$('#content').html(`
					<div id="titleContent">${data["result"][1]}</div>
					<div id="pageLeftSearch">
						<div class="searchBox">
							<b>Passaporte:</b> ${formatarNumero(passaporte)}<br>
							<b>Nome:</b> ${data["result"][1]}<br>
							<b>Telefone:</b> ${data["result"][2]}<br>
							<b>Multas:</b> $${formatarNumero(data["result"][3])}<br>
							<b>Porte:</b> ${data["result"][5] == 0 ? "Não" : "Sim"} <update id="portSearch" data-id="${passaporte}">Atualizar</update>
						</div>

						${data["result"][4].map((data) => (`
							<div class="recordBox">
								<div class="fineSeachTitle">
									<span style="width: 250px; float: left;"><b>Policial:</b> ${data["Officer"]}</span>
									<span style="width: 125px; float: left;"><b>Serviços:</b> ${formatarNumero(data["Services"])}</span>
									<span style="width: 110px; float: left;"><b>Multa:</b> $${formatarNumero(data["Fines"])}</span>
									<span style="width: 150px; float: right; text-align: right;">${data["Time"]}</span>
								</div>
								${data["About"]}
							</div>
						`)).join('')}
					</div>

					<div id="pageRight">
						<h2>OBSERVAÇÕES:</h2>
						<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com o crime efetuado, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
						<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
						<b>3:</b> Todas as prisões são salvas no sistema após o envio, então lembre-se que cada formulário enviado, o valor das multas, serviços e afins são somados com a ultima prisão caso o mesmo ainda esteja preso.
					</div>
				`);
			} else {
				$('#content').html(`
					<div id="titleContent">RESULTADO</div>
					Não foi encontrado informações sobre o passaporte procurado.
				`);
			}
		});
	}
}
/* ----------BUTTONSEARCH---------- */
$(document).on("click", ".buttonSearch", function (e) {
	const passaporte = $('#searchPassaporte').val();
	functionSearch(passaporte);
});
/* ----------PORTSEARCH---------- */
$(document).on("click", "#portSearch", function (e) {
	$.post("http://police/UpdatePort", JSON.stringify({ passaporte: e["target"]["dataset"]["id"] }));
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionPrender = () => {
	selectPage = "Prender";

	$('#content').html(`
		<div id="titleContent">PRENDER</div>
		<div id="pageLeft">
			<input class="inputPrison" id="prenderPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<input class="inputPrison" id="prenderServices" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Serviços."></input>
			<input class="inputPrison2" id="prenderMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."></input>
			<textarea class="textareaPrison" maxlength="500" id="prenderTexto" value="" placeholder="Todas as informações dos crimes:"></textarea>
			<button class="buttonPrison">Prender</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com o crime efetuado, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
			<b>3:</b> Todas as prisões são salvas no sistema após o envio, então lembre-se que cada formulário enviado, o valor das multas, serviços e afins são somados com a ultima prisão caso o mesmo ainda esteja preso.
		</div>
	`);
};
/* ----------BUTTONPRISON---------- */
$(document).on("click", ".buttonPrison", function (e) {
	const passaporte = $('#prenderPassaporte').val()
	const servicos = $('#prenderServices').val()
	const multas = $('#prenderMultas').val()
	const texto = $('#prenderTexto').val()

	if (passaporte != "" && servicos != "" && multas != "" && texto != "") {
		$.post("http://police/InitPrison", JSON.stringify({
			passaporte: parseInt(passaporte),
			servicos: parseInt(servicos),
			multas: parseInt(multas),
			texto: texto
		}));
	}
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionMultar = () => {
	selectPage = "Multar";

	$('#content').html(`
		<div id="titleContent">MULTAR</div>
		<div id="pageLeft">
			<input class="inputFine" id="multarPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<input class="inputFine2" id="multarMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."></input>
			<textarea class="textareaFine" id="multarTexto" maxlength="500" value="" placeholder="Todas as informações da multa:"></textarea>
			<button class="buttonFine">Multar</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com a multa, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
		</div>
	`);
};
/* ----------BUTTONFINE---------- */
$(document).on("click", ".buttonFine", function (e) {
	const passaporte = $('#multarPassaporte').val()
	const multas = $('#multarMultas').val()
	const texto = $('#multarTexto').val()

	if (passaporte != "" != "" && multas != "" && texto != "") {
		$.post("http://police/InitFine", JSON.stringify({
			passaporte: parseInt(passaporte),
			multas: parseInt(multas),
			texto: texto
		}));
	}
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionAnunciar = () => {
	selectPage = "Anunciar";

	$('#content').html(`
		<div id="titleContent">ANUNCIAR</div>
		<div id="pageLeft">
			<input class="inputFine" id="AnnounceTitle" value="" placeholder="Título."></input>
			<input class="inputFine2" id="AnnounceSeconds" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Segundos."></input>
			<textarea class="textareaFine" id="AnnounceText" maxlength="500" value="" placeholder="Texto do anúncio:"></textarea>
			<button class="buttonAnnounce">Anunciar</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o anúncio verifique corretamente se todas as informações estão de acordo, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
		</div>
	`);
};
/* ----------BUTTONANNOUNCE---------- */
$(document).on("click", ".buttonAnnounce", function (e) {
	const Title = $('#AnnounceTitle').val()
	const Seconds = $('#AnnounceSeconds').val()
	const Text = $('#AnnounceText').val()

	if (Title != "" != "" && Seconds != "" && Text != "") {
		$.post("http://police/Announce", JSON.stringify({
			Title: Title,
			Seconds: parseInt(Seconds),
			Text: Text
		}));
	}
});
/* ----------FORMATARNUMERO---------- */
const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}