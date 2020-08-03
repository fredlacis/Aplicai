//
//  LongText.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 03/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct LongText: View {

    /* Indicates whether the user want to see all the text or not. */
    @State private var expanded: Bool = false

    /* Indicates whether the text has been truncated in its display. */
    @State private var truncated: Bool = false

    private var text: String

    init(_ text: String) {
        self.text = text
    }

    private func determineTruncation(_ geometry: GeometryProxy) {
        // Calculate the bounding box we'd need to render the
        // text given the width from the GeometryReader.
        let total = self.text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        )

        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            Text(self.text)
                .lineLimit(self.expanded ? nil : 5)
                .fixedSize(horizontal: false, vertical: true)
                // see https://swiftui-lab.com/geometryreader-to-the-rescue/,
                // and https://swiftui-lab.com/communicating-with-the-view-tree-part-1/
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        self.determineTruncation(geometry)
                    }
                })

            if self.truncated {
                self.toggleButton
            }
        }
    }

    var toggleButton: some View {
        Button(action: { self.expanded.toggle() }) {
            Text(self.expanded ? "Ler menos" : "Ler mais")
        }
    }

}

struct LongText_Previews: PreviewProvider {
    static var previews: some View {
        LongText("teste")
    }
}
