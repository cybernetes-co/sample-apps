package main

import (
	"fmt"
	"net/http"
	"os"
)

var hostname string

func indexHandler(w http.ResponseWriter, r *http.Request) {
	hostname, _ = os.Hostname()
	fmt.Fprintf(w, "Go app running on Kubernetes! on pod %s\n", hostname)
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "OK\n")
}

func main() {
	fmt.Println("Simple web server is starting on port 8080...")
	http.HandleFunc("/", indexHandler)
	http.HandleFunc("/health", healthHandler)
	http.ListenAndServe(":8080", nil)
}
