// Implements fetch functionality
package api

import (
	log "github.com/sirupsen/logrus"
	"mongo-handler/dbhandler"
	"net/http"
)

// Handles FindById. It finds the product with id given on url .
func HandleFindById(dbh *dbhandler.MongoHandler) http.HandlerFunc {
	return func(rw http.ResponseWriter, r *http.Request) {
		log.Debug("Entered HandleFindById function .")

		var err error
		var product dbhandler.Product

		if r.Method == "POST" {
			// rgx := regexp.MustCompile(`/([0-9a-zA-Z]+)`)
			// id := rgx.FindAllStringSubmatch(r.URL.Path, -1)[0][1]

			// if product, err = dbh.FindOneById(id); err != nil {
			// 	http.Error(rw, "Unable to find product inside database .", http.StatusInternalServerError)
			// }
			// if err = product.ToJSON(rw); err != nil {
			// 	http.Error(rw, "Unable to marshal product that was found inside database .", http.StatusInternalServerError)
			// }
			fp := &dbhandler.FindPayload{}
			err = fp.FromJSON(r.Body)

			if err != nil {
				log.Errorf("Unable to Unmarshal JSON into Product struct: %s", err)
				http.Error(rw, "Unable to Unmarshal JSON into Product struct.", http.StatusBadRequest)
			}
			if product, err = dbh.FindOneById(fp.Id); err != nil {
				http.Error(rw, "Unable to find product inside database .", http.StatusInternalServerError)
		
			}
			if err = product.ToJSON(rw); err != nil {
				http.Error(rw, "Unable to marshal product that was found inside database .", http.StatusInternalServerError)
			}

		} else {
			errmsg := "Endpoint findById only supports GET method ."
			log.Error(errmsg)
			http.Error(rw, errmsg, http.StatusBadRequest)
		}
	}
}
