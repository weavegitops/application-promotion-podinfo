// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/jetstack/cert-manager/pkg/apis/acme/v1

package v1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	cmmeta "github.com/jetstack/cert-manager/pkg/apis/meta/v1"
)

// Challenge is a type to represent a Challenge request with an ACME server
// +k8s:openapi-gen=true
// +kubebuilder:printcolumn:name="State",type="string",JSONPath=".status.state"
// +kubebuilder:printcolumn:name="Domain",type="string",JSONPath=".spec.dnsName"
// +kubebuilder:printcolumn:name="Reason",type="string",JSONPath=".status.reason",description="",priority=1
// +kubebuilder:printcolumn:name="Age",type="date",JSONPath=".metadata.creationTimestamp",description="CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC."
// +kubebuilder:subresource:status
// +kubebuilder:resource:path=challenges
#Challenge: {
	metav1.#TypeMeta
	metadata: metav1.#ObjectMeta @go(ObjectMeta)
	spec:     #ChallengeSpec     @go(Spec)

	// +optional
	status: #ChallengeStatus @go(Status)
}

// ChallengeList is a list of Challenges
#ChallengeList: {
	metav1.#TypeMeta
	metadata: metav1.#ListMeta @go(ListMeta)
	items: [...#Challenge] @go(Items,[]Challenge)
}

#ChallengeSpec: {
	// The URL of the ACME Challenge resource for this challenge.
	// This can be used to lookup details about the status of this challenge.
	url: string @go(URL)

	// The URL to the ACME Authorization resource that this
	// challenge is a part of.
	authorizationURL: string @go(AuthorizationURL)

	// dnsName is the identifier that this challenge is for, e.g. example.com.
	// If the requested DNSName is a 'wildcard', this field MUST be set to the
	// non-wildcard domain, e.g. for `*.example.com`, it must be `example.com`.
	dnsName: string @go(DNSName)

	// wildcard will be true if this challenge is for a wildcard identifier,
	// for example '*.example.com'.
	// +optional
	wildcard: bool @go(Wildcard)

	// The type of ACME challenge this resource represents.
	// One of "HTTP-01" or "DNS-01".
	type: #ACMEChallengeType @go(Type)

	// The ACME challenge token for this challenge.
	// This is the raw value returned from the ACME server.
	token: string @go(Token)

	// The ACME challenge key for this challenge
	// For HTTP01 challenges, this is the value that must be responded with to
	// complete the HTTP01 challenge in the format:
	// `<private key JWK thumbprint>.<key from acme server for challenge>`.
	// For DNS01 challenges, this is the base64 encoded SHA256 sum of the
	// `<private key JWK thumbprint>.<key from acme server for challenge>`
	// text that must be set as the TXT record content.
	key: string @go(Key)

	// Contains the domain solving configuration that should be used to
	// solve this challenge resource.
	solver: #ACMEChallengeSolver @go(Solver)

	// References a properly configured ACME-type Issuer which should
	// be used to create this Challenge.
	// If the Issuer does not exist, processing will be retried.
	// If the Issuer is not an 'ACME' Issuer, an error will be returned and the
	// Challenge will be marked as failed.
	issuerRef: cmmeta.#ObjectReference @go(IssuerRef)
}

// The type of ACME challenge. Only HTTP-01 and DNS-01 are supported.
// +kubebuilder:validation:Enum=HTTP-01;DNS-01
#ACMEChallengeType: string // #enumACMEChallengeType

#enumACMEChallengeType:
	#ACMEChallengeTypeHTTP01 |
	#ACMEChallengeTypeDNS01

// ACMEChallengeTypeHTTP01 denotes a Challenge is of type http-01
// More info: https://letsencrypt.org/docs/challenge-types/#http-01-challenge
#ACMEChallengeTypeHTTP01: #ACMEChallengeType & "HTTP-01"

// ACMEChallengeTypeDNS01 denotes a Challenge is of type dns-01
// More info: https://letsencrypt.org/docs/challenge-types/#dns-01-challenge
#ACMEChallengeTypeDNS01: #ACMEChallengeType & "DNS-01"

#ChallengeStatus: {
	// Used to denote whether this challenge should be processed or not.
	// This field will only be set to true by the 'scheduling' component.
	// It will only be set to false by the 'challenges' controller, after the
	// challenge has reached a final state or timed out.
	// If this field is set to false, the challenge controller will not take
	// any more action.
	// +optional
	processing: bool @go(Processing)

	// presented will be set to true if the challenge values for this challenge
	// are currently 'presented'.
	// This *does not* imply the self check is passing. Only that the values
	// have been 'submitted' for the appropriate challenge mechanism (i.e. the
	// DNS01 TXT record has been presented, or the HTTP01 configuration has been
	// configured).
	// +optional
	presented: bool @go(Presented)

	// Contains human readable information on why the Challenge is in the
	// current state.
	// +optional
	reason?: string @go(Reason)

	// Contains the current 'state' of the challenge.
	// If not set, the state of the challenge is unknown.
	// +optional
	state?: #State @go(State)
}