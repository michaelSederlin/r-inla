## Nothing to Export

`inla.fmesher.call` <- function(
                                fmesher.call = inla.getOption("fmesher.call"),
                                all.args, prefix,
                                timeout = inla.getOption("fmesher.timeout")) {
    if (inla.os("linux") || inla.os("mac") || inla.os("mac.arm64")) {
        echoc <- system(paste(shQuote(fmesher.call), all.args, shQuote(prefix)),
            timeout = ceiling(timeout)
        )
    }
    else if (inla.os("windows")) {
        if (TRUE) {
            echoc <- try(system(paste(
                shQuote(fmesher.call),
                all.args,
                shQuote(prefix)
            ),
            timeout = ceiling(timeout)
            ),
            silent = TRUE
            )
            echoc <- 0
        } else {
            ## we might need it if we want one day to make the fmesher program run remotely
            stop("This code is not in use.")
            ##
            echoc <- try(inla.cygwin.run.command(
                paste(
                    inla.cygwin.map.filename(fmesher.call),
                    all.args,
                    inla.cygwin.map.filename(prefix)
                )
            ), silent = TRUE)
            echoc <- 0
        }
    }
    else {
          stop("\n\tNot supported architecture.")
      }
}

`inla.fmesher.make.prefix` <- function(dir = tempdir(), prefix = NULL) {
    if (is.null(prefix)) {
        if (is.null(dir)) {
              prefix <- paste(tempfile(), ".", sep = "")
          } else {
            inla.dir.create(dir)
            prefix <- paste(tempfile(tmpdir = dir), ".", sep = "")
        }
    } else {
        inla.dir.create(inla.dirname(prefix))
    }
    return(prefix)
}
