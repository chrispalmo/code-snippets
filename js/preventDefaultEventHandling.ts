import { RefObject, useEffect } from 'react';

const ALL_EVENT_TYPES = [
    'animationcancel',
    'animationend',
    'animationiteration',
    'animationstart',
    'auxclick',
    'blur',
    'error',
    'focus',
    'cancel',
    'canplay',
    'canplaythrough',
    'change',
    'click',
    'close',
    'contextmenu',
    'cuechange',
    'dblclick',
    'drag',
    'dragend',
    'dragenter',
    'dragleave',
    'dragover',
    'dragstart',
    'drop',
    'durationchange',
    'emptied',
    'ended',
    'formdata',
    'gotpointercapture',
    'input',
    'invalid',
    'keydown',
    'keypress',
    'keyup',
    'load',
    'loadeddata',
    'loadedmetadata',
    'loadend',
    'loadstart',
    'lostpointercapture',
    'mousedown',
    'mouseenter',
    'mouseleave',
    'mousemove',
    'mouseout',
    'mouseover',
    'mouseup',
    'mousewheel',
    'wheel',
    'pause',
    'play',
    'playing',
    'pointerdown',
    'pointermove',
    'pointerup',
    'pointercancel',
    'pointerover',
    'pointerout',
    'pointerenter',
    'pointerleave',
    'pointerlockchange',
    'pointerlockerror',
    'progress',
    'ratechange',
    'reset',
    'resize',
    'scroll',
    'securitypolicyviolation',
    'seeked',
    'seeking',
    'select',
    'selectstart',
    'selectionchange',
    'show',
    'slotchange',
    'stalled',
    'submit',
    'suspend',
    'timeupdate',
    'volumechange',
    'touchcancel',
    'touchend',
    'touchmove',
    'touchstart',
    'transitioncancel',
    'transitionend',
    'transitionrun',
    'transitionstart',
    'waiting',
];

const preventDefaultElement = (e: Event) => {
    e.preventDefault();
};

export const useBlockDefaultEventHandling = (elementRef: RefObject<HTMLDivElement>) => {
    useEffect(() => {
        const element = elementRef.current;
        ALL_EVENT_TYPES.forEach(eventType => {
            element?.addEventListener(eventType, preventDefaultElement);
            document.body.addEventListener(eventType, preventDefaultElement);
            window.addEventListener(eventType, preventDefaultElement);
        });
        return () => {
            ALL_EVENT_TYPES.forEach(eventType => {
                element?.removeEventListener(eventType, preventDefaultElement);
                document.body.removeEventListener(eventType, preventDefaultElement);
                window.removeEventListener(eventType, preventDefaultElement);
            });
        };
    }, [elementRef]);
};
