host space - events
enqueueEvent: aBlEvent
	"Enqueue a given Bloc Event in the event queue.
	I am useful for testing and benchmark purposes"

	eventQueue nextPut: aBlEvent.
	BlUniverse default requestNextPulse