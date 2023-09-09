MASK_BUTTON_A           equ     $01
MASK_BUTTON_B           equ     $02
JOYPAD_HELD_BUTTONS     equ     $dad7

SECTION "load_pressed_joypad_buttons", ROMX[$4f32], BANK[2]
        call    swap_a_and_b_ingame

SECTION "free_space", ROMX[$7e00], BANK[2]
swap_a_and_b_ingame::
        ; replace original instruction
        ld      a, [JOYPAD_HELD_BUTTONS]

        ld      c, a

        ; turn a button into b button
        and     MASK_BUTTON_A
        sla     a
        ld      e, a

        ; turn b button into a button
        ld      a, c
        and     MASK_BUTTON_B
        srl     a
        or      e
        ld      e, a

        ; combine with rest of buttons
        ld      a, c
        and     ~(MASK_BUTTON_A | MASK_BUTTON_B)
        or      e

        ret
