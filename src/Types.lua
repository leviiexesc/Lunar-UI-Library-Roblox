-- Lunar UI Types
export type Theme = {
    Name: string,
    MainColor: Color3,
    AccentColor: Color3,
    BackgroundColor: Color3,
    TextColor: Color3,
    SubTextColor: Color3,
    BorderColor: Color3,
    BackgroundTransparency: number,
    BlurIntensity: number,
    CornerRadius: UDim,
    Font: Font,
    AnimationSpeed: number,
}

export type LunarUI = {
    CreateWindow: (self: LunarUI, config: WindowConfig) -> Window,
    Notify: (self: LunarUI, config: NotificationConfig) -> (),
}

export type WindowConfig = {
    Title: string,
    Subtitle: string?,
    Theme: string?,
}

export type Window = {
    AddTab: (self: Window, config: TabConfig) -> Tab,
}

export type TabConfig = {
    Title: string,
    Icon: string?,
}

export type Tab = {
    AddSection: (self: Tab, config: SectionConfig) -> Section,
}

export type SectionConfig = {
    Title: string,
}

export type Section = {
    AddButton: (self: Section, config: any) -> any,
    AddToggle: (self: Section, config: any) -> any,
    AddSlider: (self: Section, config: any) -> any,
    AddDropdown: (self: Section, config: any) -> any,
    AddMultiDropdown: (self: Section, config: any) -> any,
    AddTextbox: (self: Section, config: any) -> any,
    AddKeybind: (self: Section, config: any) -> any,
    AddColorPicker: (self: Section, config: any) -> any,
    AddLabel: (self: Section, config: any) -> any,
    AddParagraph: (self: Section, config: any) -> any,
    AddSeparator: (self: Section) -> any,
    AddImage: (self: Section, config: any) -> any,
}

export type NotificationConfig = {
    Title: string,
    Content: string,
    Duration: number?,
    Type: string?,
}

return {}
