/*
 * Remember to update /assets/scss/settings/global/screensizes/screensizes.scss
 * if you decide to change breakpoint values
 */
const breakpointSizes = {
    large: 1025,
    medium: 769,
    small: 641,
};

/**
 * Create MediaQueryList using breakpoint name
 * @param {string} breakpointName
 * @return {MediaQueryList|null}
 */
export default function mediaQueryListFactory(breakpointName) {
    if (!breakpointName || !window.matchMedia) {
        return null;
    }

    const breakpoint = breakpointSizes[breakpointName];
    const mediaQuery = `(min-width: ${breakpoint}px)`;
    const mediaQueryList = window.matchMedia(mediaQuery);

    return mediaQueryList;
}
