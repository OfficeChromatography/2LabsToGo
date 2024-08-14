/**
 * Marlin 3D Printer Firmware
 * Copyright (c) 2020 MarlinFirmware [https://github.com/MarlinFirmware/Marlin]
 *
 * Based on Sprinter and grbl.
 * Copyright (c) 2011 Camiel Gubbels / Erik van der Zalm
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 */
#pragma once

#include <Arduino.h>

#ifndef NUM_DIGITAL_PINS
   // Only in ST's Arduino core (STM32duino, STM32Core)
   #error "Expected NUM_DIGITAL_PINS not found"
#endif

/**
 *  Life gets complicated if you want an easy to use 'M43 I' output (in port/pin order)
 *  because the variants in this platform do not always define all the I/O port/pins
 *  that a CPU has.
 *
 *  VARIABLES:
 *     Ard_num - Arduino pin number - defined by the platform. It is used by digitalRead and
 *               digitalWrite commands and by M42.
 *             - does not contain port/pin info
 *             - is not in port/pin order
 *             - typically a variant will only assign Ard_num to port/pins that are actually used
 *     Index - M43 counter - only used to get Ard_num
 *     x - a parameter/argument used to search the pin_array to try to find a signal name
 *         associated with a Ard_num
 *     Port_pin - port number and pin number for use with CPU registers and printing reports
 *
 *  Since M43 uses digitalRead and digitalWrite commands, only the Port_pins with an Ard_num
 *  are accessed and/or displayed.
 *
 *  Three arrays are used.
 *
 *  digitalPin[] is provided by the platform.  It consists of the Port_pin numbers in
 *  Arduino pin number order.
 *
 *  pin_array is a structure generated by the pins/pinsDebug.h header file.  It is generated by
 *  the preprocessor. Only the signals associated with enabled options are in this table.
 *  It contains:
 *    - name of the signal
 *    - the Ard_num assigned by the pins_YOUR_BOARD.h file using the platform defines.
 *        EXAMPLE:  "#define KILL_PIN  PB1" results in Ard_num of 57.  57 is then used as the
 *                  argument to digitalPinToPinName(IO) to get the Port_pin number
 *    - if it is a digital or analog signal.  PWMs are considered digital here.
 *
 *  pin_xref is a structure generated by this header file.  It is generated by the
 *  preprocessor. It is in port/pin order.  It contains just the port/pin numbers defined by the
 *  platform for this variant.
 *    - Ard_num
 *    - printable version of Port_pin
 *
 *  Routines with an "x" as a parameter/argument are used to search the pin_array to try to
 *  find a signal name associated with a port/pin.
 *
 *  NOTE -  the Arduino pin number is what is used by the M42 command, NOT the port/pin for that
 *          signal.  The Arduino pin number is listed by the M43 I command.
 */

////////////////////////////////////////////////////////
//
// make a list of the Arduino pin numbers in the Port/Pin order
//

#define _PIN_ADD(NAME_ALPHA, ARDUINO_NUM) { NAME_ALPHA, ARDUINO_NUM },
#define PIN_ADD(NAME) _PIN_ADD(#NAME, NAME)

typedef struct {
  char Port_pin_alpha[5];
  pin_t Ard_num;
} XrefInfo;

const XrefInfo pin_xref[] PROGMEM = {
  #include "pins_Xref.h"
};

////////////////////////////////////////////////////////////

#define MODE_PIN_INPUT  0 // Input mode (reset state)
#define MODE_PIN_OUTPUT 1 // General purpose output mode
#define MODE_PIN_ALT    2 // Alternate function mode
#define MODE_PIN_ANALOG 3 // Analog mode

#define PIN_NUM(P) (P & 0x000F)
#define PIN_NUM_ALPHA_LEFT(P) (((P & 0x000F) < 10) ? ('0' + (P & 0x000F)) : '1')
#define PIN_NUM_ALPHA_RIGHT(P) (((P & 0x000F) > 9)  ? ('0' + (P & 0x000F) - 10) : 0 )
#define PORT_NUM(P) ((P  >> 4) & 0x0007)
#define PORT_ALPHA(P) ('A' + (P >> 4))

/**
 * Translation of routines & variables used by pinsDebug.h
 */

#if NUM_ANALOG_FIRST >= NUM_DIGITAL_PINS
  #define HAS_HIGH_ANALOG_PINS 1
#endif
#ifndef NUM_ANALOG_LAST
  #define NUM_ANALOG_LAST ((NUM_ANALOG_FIRST) + (NUM_ANALOG_INPUTS) - 1)
#endif
#define NUMBER_PINS_TOTAL ((NUM_DIGITAL_PINS) + TERN0(HAS_HIGH_ANALOG_PINS, NUM_ANALOG_INPUTS))
#define isValidPin(P) (WITHIN(P, 0, (NUM_DIGITAL_PINS) - 1) || TERN0(HAS_HIGH_ANALOG_PINS, WITHIN(P, NUM_ANALOG_FIRST, NUM_ANALOG_LAST)))
#define digitalRead_mod(Ard_num) extDigitalRead(Ard_num)  // must use Arduino pin numbers when doing reads
#define printPinNumber(Q)
#define printPinAnalog(p) do{ sprintf_P(buffer, PSTR(" (A%2d)  "), digitalPinToAnalogIndex(pin)); SERIAL_ECHO(buffer); }while(0)
#define digitalPinToAnalogIndex(ANUM) -1  // will report analog pin number in the print port routine

// x is a variable used to search pin_array
#define getPinIsDigitalByIndex(x) ((bool) pin_array[x].is_digital)
#define getPinByIndex(x) ((pin_t) pin_array[x].pin)
#define printPinNameByIndex(x) do{ sprintf_P(buffer, PSTR("%-" STRINGIFY(MAX_NAME_LENGTH) "s"), pin_array[x].name); SERIAL_ECHO(buffer); }while(0)
#define MULTI_NAME_PAD 33 // space needed to be pretty if not first name assigned to a pin

//
// Pin Mapping for M43
//
#define GET_PIN_MAP_PIN_M43(Index) pin_xref[Index].Ard_num

#ifndef M43_NEVER_TOUCH
  #define _M43_NEVER_TOUCH(Index) (Index >= 9 && Index <= 12) // SERIAL/USB pins: PA9(TX) PA10(RX) PA11(USB_DM) PA12(USB_DP)
  #ifdef KILL_PIN
    #define M43_NEVER_TOUCH(Index) m43_never_touch(Index)

    bool m43_never_touch(const pin_t Index) {
      static pin_t M43_kill_index = -1;
      if (M43_kill_index < 0)
        for (M43_kill_index = 0; M43_kill_index < NUMBER_PINS_TOTAL; M43_kill_index++)
          if (KILL_PIN == GET_PIN_MAP_PIN_M43(M43_kill_index)) break;
      return _M43_NEVER_TOUCH(Index) || Index == M43_kill_index; // KILL_PIN and SERIAL/USB
    }
  #else
    #define M43_NEVER_TOUCH(Index) _M43_NEVER_TOUCH(Index)
  #endif
#endif

uint8_t get_pin_mode(const pin_t Ard_num) {
  const PinName dp = digitalPinToPinName(Ard_num);
  uint32_t ll_pin  = STM_LL_GPIO_PIN(dp);
  GPIO_TypeDef *port = get_GPIO_Port(STM_PORT(dp));
  uint32_t mode = LL_GPIO_GetPinMode(port, ll_pin);
  switch (mode) {
    case LL_GPIO_MODE_ANALOG: return MODE_PIN_ANALOG;
    case LL_GPIO_MODE_INPUT: return MODE_PIN_INPUT;
    case LL_GPIO_MODE_OUTPUT: return MODE_PIN_OUTPUT;
    case LL_GPIO_MODE_ALTERNATE: return MODE_PIN_ALT;
    TERN_(STM32F1xx, case LL_GPIO_MODE_FLOATING:)
    default: return 0;
  }
}

bool getValidPinMode(const pin_t Ard_num) {
  const uint8_t pin_mode = get_pin_mode(Ard_num);
  return pin_mode == MODE_PIN_OUTPUT || pin_mode == MODE_PIN_ALT;  // assume all alt definitions are PWM
}

int8_t digital_pin_to_analog_pin(const pin_t Ard_num) {
  if (WITHIN(Ard_num, NUM_ANALOG_FIRST, NUM_ANALOG_LAST))
    return Ard_num - NUM_ANALOG_FIRST;

  const int8_t ind = digitalPinToAnalogIndex(Ard_num);
  return (ind < NUM_ANALOG_INPUTS) ? ind : -1;
}

bool isAnalogPin(const pin_t Ard_num) {
  return get_pin_mode(Ard_num) == MODE_PIN_ANALOG;
}

bool is_digital(const pin_t Ard_num) {
  const uint8_t pin_mode = get_pin_mode(pin_array[Ard_num].pin);
  return pin_mode == MODE_PIN_INPUT || pin_mode == MODE_PIN_OUTPUT;
}

void printPinPort(const pin_t Ard_num) {
  char buffer[16];
  pin_t Index;
  for (Index = 0; Index < NUMBER_PINS_TOTAL; Index++)
    if (Ard_num == GET_PIN_MAP_PIN_M43(Index)) break;

  const char * ppa = pin_xref[Index].Port_pin_alpha;
  sprintf_P(buffer, PSTR("%s"), ppa);
  SERIAL_ECHO(buffer);
  if (ppa[3] == '\0') SERIAL_CHAR(' ');

  // print analog pin number
  const int8_t Port_pin = digital_pin_to_analog_pin(Ard_num);
  if (Port_pin >= 0) {
    sprintf_P(buffer, PSTR(" (A%d) "), Port_pin);
    SERIAL_ECHO(buffer);
    if (Port_pin < 10) SERIAL_CHAR(' ');
  }
  else
    SERIAL_ECHO_SP(7);

  // Print number to be used with M42
  int calc_p = Ard_num;
  if (Ard_num > NUM_DIGITAL_PINS) {
    calc_p -= NUM_ANALOG_FIRST;
    if (calc_p > 7) calc_p += 8;
  }
  SERIAL_ECHOPGM(" M42 P", calc_p);
  SERIAL_CHAR(' ');
  if (calc_p < 100) {
    SERIAL_CHAR(' ');
    if (calc_p <  10)
      SERIAL_CHAR(' ');
  }
}

bool pwm_status(const pin_t Ard_num) {
  return get_pin_mode(Ard_num) == MODE_PIN_ALT;
}

void printPinPWM(const pin_t Ard_num) {
  #ifndef STM32F1xx
    if (pwm_status(Ard_num)) {
      uint32_t alt_all = 0;
      const PinName dp = digitalPinToPinName(Ard_num);
      pin_t pin_number = uint8_t(PIN_NUM(dp));
      const bool over_7 = pin_number >= 8;
      const uint8_t ind = over_7 ? 1 : 0;
      switch (PORT_ALPHA(dp)) {  // get alt function
        case 'A' : alt_all = GPIOA->AFR[ind]; break;
        case 'B' : alt_all = GPIOB->AFR[ind]; break;
        case 'C' : alt_all = GPIOC->AFR[ind]; break;
        case 'D' : alt_all = GPIOD->AFR[ind]; break;
        #ifdef PE_0
          case 'E' : alt_all = GPIOE->AFR[ind]; break;
        #elif defined(PF_0)
          case 'F' : alt_all = GPIOF->AFR[ind]; break;
        #elif defined(PG_0)
          case 'G' : alt_all = GPIOG->AFR[ind]; break;
        #elif defined(PH_0)
          case 'H' : alt_all = GPIOH->AFR[ind]; break;
        #elif defined(PI_0)
          case 'I' : alt_all = GPIOI->AFR[ind]; break;
        #elif defined(PJ_0)
          case 'J' : alt_all = GPIOJ->AFR[ind]; break;
        #elif defined(PK_0)
          case 'K' : alt_all = GPIOK->AFR[ind]; break;
        #elif defined(PL_0)
          case 'L' : alt_all = GPIOL->AFR[ind]; break;
        #endif
      }
      if (over_7) pin_number -= 8;

      uint8_t alt_func = (alt_all >> (4 * pin_number)) & 0x0F;
      SERIAL_ECHOPGM("Alt Function: ", alt_func);
      if (alt_func < 10) SERIAL_CHAR(' ');
      SERIAL_ECHOPGM(" - ");
      switch (alt_func) {
        case  0 : SERIAL_ECHOPGM("system (misc. I/O)"); break;
        case  1 : SERIAL_ECHOPGM("TIM1/TIM2 (probably PWM)"); break;
        case  2 : SERIAL_ECHOPGM("TIM3..5 (probably PWM)"); break;
        case  3 : SERIAL_ECHOPGM("TIM8..11 (probably PWM)"); break;
        case  4 : SERIAL_ECHOPGM("I2C1..3"); break;
        case  5 : SERIAL_ECHOPGM("SPI1/SPI2"); break;
        case  6 : SERIAL_ECHOPGM("SPI3"); break;
        case  7 : SERIAL_ECHOPGM("USART1..3"); break;
        case  8 : SERIAL_ECHOPGM("USART4..6"); break;
        case  9 : SERIAL_ECHOPGM("CAN1/CAN2, TIM12..14  (probably PWM)"); break;
        case 10 : SERIAL_ECHOPGM("OTG"); break;
        case 11 : SERIAL_ECHOPGM("ETH"); break;
        case 12 : SERIAL_ECHOPGM("FSMC, SDIO, OTG"); break;
        case 13 : SERIAL_ECHOPGM("DCMI"); break;
        case 14 : SERIAL_ECHOPGM("unused (shouldn't see this)"); break;
        case 15 : SERIAL_ECHOPGM("EVENTOUT"); break;
      }
    }
  #else
    // TODO: F1 doesn't support changing pins function, so we need to check the function of the PIN and if it's enabled
  #endif
} // printPinPWM
