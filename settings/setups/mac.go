package setup

func Mac(advance bool, noInternet bool) {
	if advance {
		MacAdvanceWithoutInternet()
		if !noInternet {
			MacAdvanceWithInternet()
		}
	} else {
		MacWithoutInternet()
		if !noInternet {
			MacWithInternet()
		}
	}
}
